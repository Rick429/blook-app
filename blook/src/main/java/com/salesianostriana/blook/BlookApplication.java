package com.salesianostriana.blook;

import com.salesianostriana.blook.config.StorageProperties;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;

@EnableConfigurationProperties(StorageProperties.class)
@SpringBootApplication
public class BlookApplication {

	public static void main(String[] args) {
		SpringApplication.run(BlookApplication.class, args);
	}

}
