package info.matsumana.example;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class Application {

    private static final Logger log = LoggerFactory.getLogger(Application.class);

    public static void main(String[] args) {
        Runtime.getRuntime()
               .addShutdownHook(new Thread(() -> log.info("Start Shutdown...")));

        SpringApplication.run(Application.class, args);
    }
}
