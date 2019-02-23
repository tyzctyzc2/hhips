package hhips.air;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Component;

@Configuration
@PropertySource(value="classpath:application.properties")
@Component
public class PropConfig {
    @Value("${web.upload.path}")
    public String absolutePath = "";

    public String getAbsolutePath() {
        return absolutePath;
    }
}
