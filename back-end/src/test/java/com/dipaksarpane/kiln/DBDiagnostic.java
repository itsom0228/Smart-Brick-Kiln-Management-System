package com.dipaksarpane.kiln;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class DBDiagnostic {
    public static void main(String[] args) {
        String url = System.getenv("SPRING_DATASOURCE_URL");
        String user = System.getenv("SPRING_DATASOURCE_USERNAME");
        String pass = System.getenv("SPRING_DATASOURCE_PASSWORD");

        if (url == null || user == null || pass == null) {
            System.err.println("Error: Missing database environment variables (SPRING_DATASOURCE_URL, SPRING_DATASOURCE_USERNAME, SPRING_DATASOURCE_PASSWORD).");
            return;
        }

        try {
            Class.forName("org.postgresql.Driver");
            System.out.println("Connecting to Aiven PostgreSQL...");
            try (Connection conn = DriverManager.getConnection(url, user, pass)) {
                System.out.println("Connection successful!");

                System.out.println("\n--- Active Database Connections ---");
                try (Statement stmt = conn.createStatement();
                     ResultSet rs = stmt.executeQuery("SELECT pid, usename, client_addr, state, query, backend_start FROM pg_stat_activity WHERE datname = 'defaultdb'")) {
                    while (rs.next()) {
                        System.out.printf("PID: %d | User: %s | Addr: %s | State: %s | Query: %s | Started: %s\n",
                                rs.getInt("pid"),
                                rs.getString("usename"),
                                rs.getString("client_addr"),
                                rs.getString("state"),
                                rs.getString("query"),
                                rs.getString("backend_start")
                        );
                    }
                }

                System.out.println("\n--- Locked/Blocked Queries ---");
                try (Statement stmt = conn.createStatement();
                     ResultSet rs = stmt.executeQuery(
                             "SELECT blocked_locks.pid     AS blocked_pid, " +
                             "       blocked_activity.query  AS blocked_statement, " +
                             "       blocking_locks.pid    AS blocking_pid, " +
                             "       blocking_activity.query AS blocking_statement " +
                             "FROM  pg_catalog.pg_locks         blocked_locks " +
                             "JOIN pg_catalog.pg_stat_activity blocked_activity ON blocked_activity.pid = blocked_locks.pid " +
                             "JOIN pg_catalog.pg_locks         blocking_locks " +
                             "  ON blocking_locks.locktype = blocked_locks.locktype " +
                             "  AND blocking_locks.database IS NOT DISTINCT FROM blocked_locks.database " +
                             "  AND blocking_locks.relation IS NOT DISTINCT FROM blocked_locks.relation " +
                             "  AND blocking_locks.page IS NOT DISTINCT FROM blocked_locks.page " +
                             "  AND blocking_locks.tuple IS NOT DISTINCT FROM blocked_locks.tuple " +
                             "  AND blocking_locks.virtualxid IS NOT DISTINCT FROM blocked_locks.virtualxid " +
                             "  AND blocking_locks.transactionid IS NOT DISTINCT FROM blocked_locks.transactionid " +
                             "  AND blocking_locks.classid IS NOT DISTINCT FROM blocked_locks.classid " +
                             "  AND blocking_locks.objid IS NOT DISTINCT FROM blocked_locks.objid " +
                             "  AND blocking_locks.objsubid IS NOT DISTINCT FROM blocked_locks.objsubid " +
                             "  AND blocking_locks.pid != blocked_locks.pid " +
                             "JOIN pg_catalog.pg_stat_activity blocking_activity ON blocking_activity.pid = blocking_locks.pid " +
                             "WHERE NOT blocked_locks.granted")) {
                    boolean found = false;
                    while (rs.next()) {
                        found = true;
                        System.out.printf("Blocked PID: %d (%s) | Blocked by PID: %d (%s)\n",
                                rs.getInt("blocked_pid"),
                                rs.getString("blocked_statement"),
                                rs.getInt("blocking_pid"),
                                rs.getString("blocking_statement")
                        );
                    }
                    if (!found) {
                        System.out.println("No blocked queries/deadlocks found.");
                    }
                }

            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
