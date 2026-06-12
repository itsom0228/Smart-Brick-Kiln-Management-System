package com.dipaksarpane.kiln.service;

import com.dipaksarpane.kiln.entity.Admin;
import com.dipaksarpane.kiln.entity.Product;
import com.dipaksarpane.kiln.entity.Review;
import com.dipaksarpane.kiln.entity.SystemSetting;
import com.dipaksarpane.kiln.repository.AdminRepository;
import com.dipaksarpane.kiln.repository.ProductRepository;
import com.dipaksarpane.kiln.repository.ReviewRepository;
import com.dipaksarpane.kiln.repository.SystemSettingRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import javax.sql.DataSource;
import org.springframework.transaction.annotation.Transactional;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Component
public class DatabaseSeeder implements CommandLineRunner {

    private final AdminRepository adminRepository;
    private final ProductRepository productRepository;
    private final ReviewRepository reviewRepository;
    private final SystemSettingRepository systemSettingRepository;
    private final PasswordEncoder passwordEncoder;
    private final DataSource dataSource;

    @PersistenceContext
    private EntityManager entityManager;

    public DatabaseSeeder(AdminRepository adminRepository, 
                          ProductRepository productRepository, 
                          ReviewRepository reviewRepository,
                          SystemSettingRepository systemSettingRepository,
                          PasswordEncoder passwordEncoder,
                          DataSource dataSource) {
        this.adminRepository = adminRepository;
        this.productRepository = productRepository;
        this.reviewRepository = reviewRepository;
        this.systemSettingRepository = systemSettingRepository;
        this.passwordEncoder = passwordEncoder;
        this.dataSource = dataSource;
    }

    @Override
    @Transactional
    public void run(String... args) throws Exception {
        // 1. Seed Admin User
        if (adminRepository.count() == 0) {
            Admin admin = new Admin();
            admin.setUsername("admin");
            admin.setPassword(passwordEncoder.encode("Admin@123"));
            admin.setRole("ADMIN");
            adminRepository.save(admin);
            System.out.println(">>> Database Seeder: Admin account seeded successfully (admin / Admin@123)");
        }

        // 1.5. Seed System Settings
        if (systemSettingRepository.count() == 0) {
            systemSettingRepository.save(new SystemSetting("GST_RATE", "12"));
            systemSettingRepository.save(new SystemSetting("TRANSPORT_RATE_STANDARD", "1.50"));
            systemSettingRepository.save(new SystemSetting("TRANSPORT_RATE_HOLLOW", "5.00"));
            systemSettingRepository.save(new SystemSetting("TRANSPORT_LOCAL", "0"));
            systemSettingRepository.save(new SystemSetting("TRANSPORT_PARANDA", "1500"));
            systemSettingRepository.save(new SystemSetting("TRANSPORT_DHARASHIV", "3500"));
            systemSettingRepository.save(new SystemSetting("TRANSPORT_LONG", "5000"));
            System.out.println(">>> Database Seeder: System settings seeded successfully.");
        }

        // 2. Seed Products
        if (productRepository.count() == 0) {
            Product p1 = new Product(
                "Red Bricks", 
                "RED001", 
                "Premium quality red clay bricks baked in a high-efficiency kiln. Perfect for load-bearing walls and general masonry.",
                "9 x 4 x 3 inches", 
                "3.0 kg", 
                "7.5 N/mm²", 
                BigDecimal.valueOf(7.00), 
                50000, 
                10000, 
                "/images/red-bricks.jpg"
            );

            Product p2 = new Product(
                "Fly Ash Bricks", 
                "FLY001", 
                "Environment-friendly bricks composed of fly ash, cement, sand, and water. Very uniform shape and high thermal resistance.",
                "9 x 4 x 3 inches", 
                "2.8 kg", 
                "8.0 N/mm²", 
                BigDecimal.valueOf(6.00), 
                40000, 
                8000, 
                "/images/flyash-bricks.jpg"
            );

            Product p3 = new Product(
                "Hollow Bricks", 
                "HOL001", 
                "Lightweight hollow clay blocks. Provides excellent sound insulation and thermal regulation for high-rise partition walls.",
                "16 x 8 x 8 inches", 
                "12.0 kg", 
                "5.0 N/mm²", 
                BigDecimal.valueOf(25.00), 
                15000, 
                3000, 
                "/images/hollow-bricks.jpg"
            );

            Product p4 = new Product(
                "Concrete Blocks", 
                "CON001", 
                "Solid concrete building block, cast with gravel aggregate. Used for strong outer boundary walls, foundation structures, and commercial spaces.",
                "16 x 8 x 8 inches", 
                "18.0 kg", 
                "10.0 N/mm²", 
                BigDecimal.valueOf(35.00), 
                10000, 
                2000, 
                "/images/concrete-blocks.jpg"
            );

            Product p5 = new Product(
                "Paver Blocks", 
                "PAV001", 
                "High-strength interlocking concrete pavers. Heavy-duty blocks designed for driveways, parking spaces, and pathways.",
                "8 x 4 x 2.5 inches", 
                "4.5 kg", 
                "30.0 N/mm²", 
                BigDecimal.valueOf(15.00), 
                20000, 
                5000, 
                "/images/paver-blocks.jpg"
            );

            productRepository.save(p1);
            productRepository.save(p2);
            productRepository.save(p3);
            productRepository.save(p4);
            productRepository.save(p5);
            System.out.println(">>> Database Seeder: Product catalog seeded successfully.");
        }

        // 3. Seed Reviews
        if (reviewRepository.count() == 0) {
            Review r1 = new Review("Ramesh Patil", 5, "Outstanding quality Red Bricks. Compressive strength is highly durable. Delivered 20,000 bricks right on schedule!", true, LocalDateTime.now().minusDays(5));
            Review r2 = new Review("Sunita Deshmukh", 5, "Fly ash bricks are uniform in shape and saved us mortar cost. Dipak Sarpane Brick Industries is highly recommended!", true, LocalDateTime.now().minusDays(3));
            Review r3 = new Review("Vijay Kulkarni", 4, "Very transparent pricing. The online price calculator gave an exact estimate that matched the final invoice.", true, LocalDateTime.now().minusDays(1));
            
            reviewRepository.save(r1);
            reviewRepository.save(r2);
            reviewRepository.save(r3);
            System.out.println(">>> Database Seeder: Reviews seeded successfully.");
        }
    }
}
