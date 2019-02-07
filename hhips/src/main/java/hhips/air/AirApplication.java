package hhips.air;

import org.slf4j.LoggerFactory;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import uti.FileHelper;

import javax.annotation.PostConstruct;
import java.io.IOException;

@SpringBootApplication(scanBasePackages={"report","hhips.air","db", "model", "editor"})
@EntityScan("db")
public class AirApplication extends SpringBootServletInitializer {
    private static final org.slf4j.Logger logger = LoggerFactory.getLogger(AirApplication.class);

	public static void main(String[] args) throws IOException {

		FileHelper.absolutePath = "D:\\javacode\\hhips\\hhips\\target\\classes\\static\\";

		SpringApplication.run(AirApplication.class, args);
	}

	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder builder) {
		//FileHelper.absolutePath = "D:\\Program Files\\Apache Software Foundation\\Tomcat 9.0\\webapps\\hhipsair\\WEB-INF\\classes\\static\\";
		String staticPath = System.getProperty("user.dir") + "\\webapps\\hhipsair\\WEB-INF\\classes\\static\\";
		//get tomcat path
        int startTom = staticPath.indexOf("Tomcat");
        int endTom = staticPath.indexOf("\\", startTom);
        staticPath = staticPath.substring(0, endTom);
		System.out.println("Set Working Directory = " +    staticPath);
		logger.info("Set Working Directory = " +    staticPath);

		FileHelper.absolutePath = staticPath;
		return builder.sources(AirApplication.class);
	}

    @PostConstruct
    public void init() {
        String staticPath = System.getProperty("user.dir") + "\\webapps\\hhipsair\\WEB-INF\\classes\\static\\";
        //get tomcat path
        int startTom = staticPath.indexOf("Tomcat");
        int endTom = staticPath.indexOf("\\", startTom);
        staticPath = staticPath.substring(0, endTom);
        staticPath = staticPath + "\\webapps\\hhipsair\\WEB-INF\\classes\\static\\";
        System.out.println("Set Working Directory = " +    staticPath);
        logger.info("PostConstruct Set Working Directory = " +    staticPath);

        FileHelper.absolutePath = staticPath;
    }

}
