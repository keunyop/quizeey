package com.questionbank.webservice;

import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;

@EnableJpaAuditing // JPA Auditing
@SpringBootApplication
public class Application {

    public static final String APPLICATION_LOCATIONS = "spring.config.location=" + "classpath:application.yml,"
	    + "/home/ec2-user/app/config/real-application.yml";

    public static void main(String[] args) {
	new SpringApplicationBuilder(Application.class).properties(APPLICATION_LOCATIONS).run(args);
    }

//    public static void main(String[] args) {
//	SpringApplication.run(Application.class, args);
//    }

}
