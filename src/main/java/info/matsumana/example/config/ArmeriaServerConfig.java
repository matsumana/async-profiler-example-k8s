package info.matsumana.example.config;

import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.linecorp.armeria.server.logging.LoggingService;
import com.linecorp.armeria.spring.ArmeriaServerConfigurator;

import info.matsumana.example.controller.RootController;

@Configuration
public class ArmeriaServerConfig {

    @Bean
    public ArmeriaServerConfigurator armeriaServerConfigurator(RootController rootController) {
        return serverBuilder -> serverBuilder
                .annotatedService()
                .decorator(LoggingService.builder()
                                         .logger(LoggerFactory.getLogger(RootController.class))
                                         .newDecorator())
                .build(rootController);
    }
}
