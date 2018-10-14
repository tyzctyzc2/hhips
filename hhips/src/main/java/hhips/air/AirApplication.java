package hhips.air;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import report.DaySummaryGenerator;
import uti.FileHelper;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Path;
import java.nio.file.Paths;

import static java.util.Locale.ROOT;

@SpringBootApplication(scanBasePackages={"report","hhips.air","db"})
public class AirApplication extends SpringBootServletInitializer {

	public static void main(String[] args) throws IOException {
		DaySummaryGenerator dg = new DaySummaryGenerator();
		//dg.run();

		//FileHelper.absolutePath = "D:\\spring\\hhips\\target\\classes\\static\\";
		FileHelper.absolutePath = "D:\\javacode\\hhips\\hhips\\target\\classes\\static\\";

		SpringApplication.run(AirApplication.class, args);
	}

	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder builder) {
		//FileHelper.absolutePath = "D:\\Program Files\\Apache Software Foundation\\Tomcat 9.0\\webapps\\hhipsair\\WEB-INF\\classes\\static\\";
		String staticPath = System.getProperty("user.dir") + "\\webapps\\hhipsair\\WEB-INF\\classes\\static\\";
		System.out.println("Set Working Directory = " +    staticPath);

		FileHelper.absolutePath = staticPath;
		return builder.sources(AirApplication.class);
	}

}
