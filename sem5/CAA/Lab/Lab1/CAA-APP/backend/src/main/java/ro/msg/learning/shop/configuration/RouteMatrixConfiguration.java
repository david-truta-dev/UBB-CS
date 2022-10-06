package ro.msg.learning.shop.configuration;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

@Configuration
@Data
@ConfigurationProperties(prefix = "ro.msg.learning.shop.routematrix")
public class RouteMatrixConfiguration {

    private String url;
    private String key;
}