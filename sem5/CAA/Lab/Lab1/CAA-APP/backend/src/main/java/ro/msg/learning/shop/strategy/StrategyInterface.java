package ro.msg.learning.shop.strategy;

import ro.msg.learning.shop.dto.OrderProductQuantityDTO;
import ro.msg.learning.shop.model.LocationStrategyModel;

import java.util.List;

public interface StrategyInterface {

    List<LocationStrategyModel> getLocations(OrderProductQuantityDTO order);
}
