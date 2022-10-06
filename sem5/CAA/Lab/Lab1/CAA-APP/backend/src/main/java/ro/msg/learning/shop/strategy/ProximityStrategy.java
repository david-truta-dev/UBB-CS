package ro.msg.learning.shop.strategy;

import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.web.client.RestTemplate;
import ro.msg.learning.shop.configuration.RouteMatrixConfiguration;
import ro.msg.learning.shop.dto.OrderProductQuantityDTO;
import ro.msg.learning.shop.dto.ProductAndQuantityDTO;
import ro.msg.learning.shop.entity.Location;
import ro.msg.learning.shop.entity.Stock;
import ro.msg.learning.shop.exception.NoLocationException;
import ro.msg.learning.shop.model.DistanceRequestModel;
import ro.msg.learning.shop.model.DistanceResponseModel;
import ro.msg.learning.shop.model.LocationStrategyModel;
import ro.msg.learning.shop.repository.LocationRepository;
import ro.msg.learning.shop.repository.ProductRepository;
import ro.msg.learning.shop.repository.StockRepository;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@RequiredArgsConstructor
public class ProximityStrategy implements StrategyInterface {

    private final RouteMatrixConfiguration routeMatrix;
    private final LocationRepository locationRepository;
    private final StockRepository stockRepository;
    private final ProductRepository productRepository;

    @Override
    public List<LocationStrategyModel> getLocations(OrderProductQuantityDTO order) {

        List<Location> closestLocations = getSortedLocations(order);
        int numberOfOrders = order.getProducts().size();
        List<LocationStrategyModel> proximityLocations = new ArrayList<>();

        for (Location location : closestLocations) {

            List<Stock> stocks = stockRepository.findAllByStockIdLocationId(location.getId());
            final LocationStrategyModel[] proximityLocation = {null};

            stocks.forEach(stock -> {
                               List<ProductAndQuantityDTO> productsFound = new ArrayList<>();
                               order.getProducts().forEach(o -> {
                                                               if (o.getId().equals(stock.getStockId().getProductId()) &&
                                                                   stock.getQuantity() >= o.getQuantity()
                                                               ) {
                                                                   productRepository.findById(o.getId()).ifPresent(orderProduct -> {
                                                                                                                       proximityLocation[0] = new LocationStrategyModel(location, orderProduct, o.getQuantity());
                                                                                                                       proximityLocations.add(proximityLocation[0]);
                                                                                                                       productsFound.add(o);
                                                                                                                   }
                                                                                                                  );
                                                               }
                                                           }
                                                          );
                               order.getProducts().removeAll(productsFound);
                           }
                          );
        }

        if (proximityLocations.isEmpty() || proximityLocations.size() != numberOfOrders) {
            throw new NoLocationException();
        } else {
            return proximityLocations;
        }
    }

    private List<Location> getSortedLocations(OrderProductQuantityDTO order) {

        List<String> locationList = new ArrayList<>();

        String orderAddress = order.getAddressCountry() + "," +
                              order.getAddressCounty() + "," +
                              order.getAddressCity() + "," +
                              order.getAddressStreetAddress();

        locationList.add(orderAddress);

        locationList.addAll(
            locationRepository.findAll().stream()
                              .map(location -> location.getAddressCountry() + "," +
                                               location.getAddressCounty() + "," +
                                               location.getAddressCity() + "," +
                                               location.getAddressStreetAddress())
                              .collect(Collectors.toList()));

        DistanceResponseModel distanceResponse = getDistance(locationList);
        List<Long> distanceBetweenLocations = distanceResponse.getDistance();

        Map<Long, Location> map = new HashMap<>();
        for (int i = 1; i < distanceBetweenLocations.size(); i++) {
            map.put(distanceBetweenLocations.get(i), locationRepository.findAll().get(i - 1));
        }

        return new ArrayList<>(map.values());
    }

    private DistanceResponseModel getDistance(List<String> locationList) {

        String routeMatrixURL = routeMatrix.getUrl() + routeMatrix.getKey();
        RestTemplate restTemplate = new RestTemplate();
        HttpEntity<DistanceRequestModel> request = new HttpEntity<>(new DistanceRequestModel(locationList, true));
        ResponseEntity<DistanceResponseModel> distanceResponse = restTemplate
            .exchange(routeMatrixURL, HttpMethod.POST, request, DistanceResponseModel.class);
        return distanceResponse.getBody();
    }
}
