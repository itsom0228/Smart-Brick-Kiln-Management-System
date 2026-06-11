package com.dipaksarpane.kiln;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

@SpringBootApplication
public class KilnApplication extends SpringBootServletInitializer {

    public static void main(String[] args) {
        SpringApplication.run(KilnApplication.class, args);
    }
}
