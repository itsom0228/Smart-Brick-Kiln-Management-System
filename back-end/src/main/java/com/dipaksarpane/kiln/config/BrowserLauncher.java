package com.dipaksarpane.kiln.config;

import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.boot.web.context.WebServerApplicationContext;
import org.springframework.context.ApplicationListener;
import org.springframework.stereotype.Component;

// @Component
public class BrowserLauncher implements ApplicationListener<ApplicationReadyEvent> {

    @Override
    public void onApplicationEvent(ApplicationReadyEvent event) {
        try {
            int port = 8080; // default fallback
            
            // Extract the actual running port from WebServerApplicationContext dynamically
            if (event.getApplicationContext() instanceof WebServerApplicationContext webServerContext) {
                port = webServerContext.getWebServer().getPort();
            } else {
                String envPort = event.getApplicationContext().getEnvironment().getProperty("server.port");
                if (envPort != null) {
                    port = Integer.parseInt(envPort);
                }
            }

            String url = "http://localhost:" + port + "/";
            System.out.println(">>> Smart Brick Kiln: Server running on port " + port + ". Launching default web browser...");

            // Trigger OS start command
            String os = System.getProperty("os.name").toLowerCase();
            Runtime rt = Runtime.getRuntime();
            
            if (os.contains("win")) {
                rt.exec(new String[]{"cmd", "/c", "start", url});
            } else if (os.contains("mac")) {
                rt.exec(new String[]{"open", url});
            } else if (os.contains("nix") || os.contains("nux")) {
                rt.exec(new String[]{"xdg-open", url});
            }
        } catch (Exception e) {
            System.err.println(">>> Failed to launch browser automatically: " + e.getMessage());
        }
    }
}
