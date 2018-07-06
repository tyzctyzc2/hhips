package hhips.air;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import uti.FileHelper;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Path;
import java.nio.file.Paths;

import static java.util.Locale.ROOT;

@SpringBootApplication
public class AirApplication {

	public static void main(String[] args) throws IOException {
		FileHelper.absolutePath = "D:\\spring\\hhips\\target\\classes\\static\\";

		SpringApplication.run(AirApplication.class, args);
	}
}
