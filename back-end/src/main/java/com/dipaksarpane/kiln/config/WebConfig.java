package com.dipaksarpane.kiln.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.i18n.CookieLocaleResolver;
import org.springframework.web.servlet.i18n.LocaleChangeInterceptor;
import java.time.Duration;
import java.util.Locale;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Bean
    public LocaleResolver localeResolver() {
        CookieLocaleResolver resolver = new CookieLocaleResolver("client-locale");
        resolver.setDefaultLocale(Locale.ENGLISH); // Default to English
        resolver.setCookieMaxAge(Duration.ofDays(30)); // Save language for 30 days
        return resolver;
    }

    @Bean
    public LocaleChangeInterceptor localeChangeInterceptor() {
        LocaleChangeInterceptor interceptor = new LocaleChangeInterceptor();
        interceptor.setParamName("lang"); // URL parameter: ?lang=en, ?lang=mr, ?lang=hi
        return interceptor;
    }

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(localeChangeInterceptor());
    }

    @Bean
    public org.springframework.boot.web.server.WebServerFactoryCustomizer<org.springframework.boot.web.servlet.server.ConfigurableServletWebServerFactory> webServerFactoryCustomizer() {
        return factory -> {
            if (factory instanceof org.springframework.boot.web.embedded.tomcat.TomcatServletWebServerFactory) {
                org.springframework.boot.web.embedded.tomcat.TomcatServletWebServerFactory tomcat = 
                    (org.springframework.boot.web.embedded.tomcat.TomcatServletWebServerFactory) factory;
                java.io.File webappDir = new java.io.File("../front-end/webapp");
                if (webappDir.exists()) {
                    tomcat.setDocumentRoot(webappDir);
                }
                
                // Optimize Tomcat context for Docker and slow-disk container environments
                tomcat.addContextCustomizers(context -> {
                    context.setReloadable(false);
                    // Use ExtractingRoot to extract JSPs and resources out of the WAR package
                    context.setResources(new org.apache.catalina.webresources.ExtractingRoot());
                    
                    // Allow caching of scanned web resources to speed up loads
                    if (context.getResources() != null) {
                        context.getResources().setCachingAllowed(true);
                        context.getResources().setCacheMaxSize(102400); // 100MB cache
                    }
                });
            }
        };
    }
}
