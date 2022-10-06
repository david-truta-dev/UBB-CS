package ro.msg.learning.shop.strategy;

import lombok.RequiredArgsConstructor;
import ro.msg.learning.shop.dto.OrderProductQuantityDTO;
import ro.msg.learning.shop.dto.ProductAndQuantityDTO;
import ro.msg.learning.shop.entity.Location;
import ro.msg.learning.shop.entity.Product;
import ro.msg.learning.shop.entity.Stock;
import ro.msg.learning.shop.exception.NoLocationException;
import ro.msg.learning.shop.model.LocationStrategyModel;
import ro.msg.learning.shop.repository.LocationRepository;
import ro.msg.learning.shop.repository.ProductRepository;
import ro.msg.learning.shop.repository.StockRepository;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@RequiredArgsConstructor
public class MostAbundantStrategy implements StrategyInterface {

    private final LocationRepository locationRepository;
    private final StockRepository stockRepository;
    private final ProductRepository productRepository;

    @Override
    public List<LocationStrategyModel> getLocations(
            OrderProductQuantityDTO order) {

        List<LocationStrategyModel> locations = new ArrayList<>();
        for (ProductAndQuantityDTO product : order.getProducts()) {

            List<Location> locationsWithProduct = locationRepository.findAll()
                                                                    .stream()
                                                                    .filter(location -> hasLocationProduct(
                                                                            product,
                                                                            location))
                                                                    .collect(
                                                                            Collectors.toList());

            int maxQuantity = 0;
            LocationStrategyModel mostAbundantLocation = null;
            for (Location location : locationsWithProduct) {
                Integer stockQuantity = stockRepository.findAll()
                                                       .stream()
                                                       .filter(stock -> stock.getStockId()
                                                                             .getLocationId()
                                                                             .equals(location.getId()))
                                                       .filter(stock -> stock.getStockId()
                                                                             .getProductId()
                                                                             .equals(product.getId()))
                                                       .map(Stock::getQuantity)
                                                       .findFirst()
                                                       .orElse(null);

                if (stockQuantity != null && maxQuantity < stockQuantity && stockQuantity >= product.getQuantity()) {

                    maxQuantity = stockQuantity;
                    Product orderProduct = productRepository.findById(
                            product.getId())
                                                            .orElse(null);

                    if (orderProduct != null) {
                        mostAbundantLocation = new LocationStrategyModel(
                                location, orderProduct,
                                product.getQuantity());
                    }
                }
            }

            if (mostAbundantLocation != null)
                locations.add(mostAbundantLocation);
        }

        if (locations.isEmpty() || locations.size() != order.getProducts()
                                                            .size())
            throw new NoLocationException();
        else {
            return locations;
        }
    }

    private boolean hasLocationProduct(ProductAndQuantityDTO product,
                                       Location location) {

        List<Integer> stockProductsId = stockRepository.findAll()
                                                       .stream()
                                                       .filter(stock -> stock.getStockId()
                                                                             .getLocationId()
                                                                             .equals(location.getId()))
                                                       .map(stock -> stock.getStockId()
                                                                          .getProductId())
                                                       .collect(
                                                               Collectors.toList());

        return stockProductsId.contains(product.getId());
    }
}
