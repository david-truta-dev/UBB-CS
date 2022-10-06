package ro.msg.learning.shop.configuration;


import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import ro.msg.learning.shop.exception.NoStrategyException;
import ro.msg.learning.shop.repository.LocationRepository;
import ro.msg.learning.shop.repository.ProductRepository;
import ro.msg.learning.shop.repository.StockRepository;
import ro.msg.learning.shop.strategy.MostAbundantStrategy;
import ro.msg.learning.shop.strategy.ProximityStrategy;
import ro.msg.learning.shop.strategy.SingleLocationStrategy;
import ro.msg.learning.shop.strategy.StrategyInterface;

@Slf4j
@Configuration
public class StrategyConfiguration {

    @Value("${strategy}")
    private String strategy;

    @Bean
    public StrategyInterface getStrategy(LocationRepository locationRepository,
                                         StockRepository stockRepository,
                                         ProductRepository productRepository,
                                         RouteMatrixConfiguration routeMatrix) {

        log.info("using " + strategy + " strategy");
        switch (strategy) {
            case "single location":
                return new SingleLocationStrategy(stockRepository,
                                                  locationRepository,
                                                  productRepository);

            case "most abundant":
                return new MostAbundantStrategy(locationRepository,
                                                stockRepository,
                                                productRepository);

            case "proximity":
                return new ProximityStrategy(routeMatrix, locationRepository,
                                             stockRepository,
                                             productRepository);

            default:
                throw new NoStrategyException();
        }
    }
}
