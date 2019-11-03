package hhips.air;

import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.AutoConfigurationPackage;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.orm.hibernate5.LocalSessionFactoryBean;
import uti.FileHelper;

import javax.annotation.PostConstruct;
import java.io.IOException;

@SpringBootApplication(scanBasePackages={"report","hhips.air","db", "model", "editor","repository"})
@EntityScan("db")
@EnableAutoConfiguration
@PropertySource(value="classpath:application.properties")
@Configuration
//@AutoConfigurationPackage
//@EnableJpaRepositories("repository")
public class AirApplication extends SpringBootServletInitializer {
    private static final org.slf4j.Logger logger = LoggerFactory.getLogger(AirApplication.class);

    public static void main(String[] args) throws IOException {
        SpringApplication.run(AirApplication.class, args);
    }

    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder builder) {
        return builder.sources(AirApplication.class);
    }
}
