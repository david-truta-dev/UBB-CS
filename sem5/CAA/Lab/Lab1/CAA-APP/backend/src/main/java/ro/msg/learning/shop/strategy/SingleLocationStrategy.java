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
public class SingleLocationStrategy implements StrategyInterface {

    private final StockRepository stockRepository;
    private final LocationRepository locationRepository;
    private final ProductRepository productRepository;

    @Override
    public List<LocationStrategyModel> getLocations(
            OrderProductQuantityDTO order) {

        List<Location> locations = locationRepository.findAll()
                                                     .stream()
                                                     .filter(location -> hasLocationAllProductsAndStock(
                                                             order.getProducts(),
                                                             location))
                                                     .collect(
                                                             Collectors.toList());

        Location location = locations.stream()
                                     .findFirst()
                                     .orElse(null);
        if (location == null)
            throw new NoLocationException();
        else {
            List<LocationStrategyModel> singleLocation = new ArrayList<>();
            LocationStrategyModel locationStrategyModel;

            for (ProductAndQuantityDTO orderProduct : order.getProducts()) {
                Product product = productRepository.findById(
                        orderProduct.getId())
                                                   .orElse(null);
                if (product != null) {
                    locationStrategyModel = new LocationStrategyModel(location,
                                                                      product,
                                                                      orderProduct.getQuantity());
                    singleLocation.add(locationStrategyModel);
                }
            }

            return singleLocation;
        }
    }

    private boolean hasLocationAllProductsAndStock(
            List<ProductAndQuantityDTO> products, Location location) {

        List<Stock> stockList = stockRepository.findAll()
                                               .stream()
                                               .filter(stock -> stock.getStockId()
                                                                     .getLocationId()
                                                                     .equals(location.getId()))
                                               .collect(Collectors.toList());

        List<Integer> stockProductsId = stockList.stream()
                                                 .map(stock -> stock.getStockId()
                                                                    .getProductId())
                                                 .collect(Collectors.toList());

        if (stockProductsId.containsAll(products.stream()
                                                .map(ProductAndQuantityDTO::getId)
                                                .collect(
                                                        Collectors.toList()))) {

            return stockList.stream()
                            .allMatch(stock -> verifyQuantityStockExists(stock,
                                                                         products));
        } else {
            return false;
        }
    }

    private boolean verifyQuantityStockExists(Stock stock,
                                              List<ProductAndQuantityDTO> products) {

        ProductAndQuantityDTO product = products.stream()
                                                .filter(p -> stock.getStockId()
                                                                  .getProductId()
                                                                  .equals(p.getId()))
                                                .findFirst()
                                                .orElse(null);

        if (product != null)
            return product.getQuantity() <= stock.getQuantity();
        else
            return false;
    }
}
