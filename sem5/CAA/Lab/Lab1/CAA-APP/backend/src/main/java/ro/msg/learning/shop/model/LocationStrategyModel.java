package ro.msg.learning.shop.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import ro.msg.learning.shop.entity.Location;
import ro.msg.learning.shop.entity.Product;

@Data
@AllArgsConstructor
public class LocationStrategyModel {

        private Location location;
        private Product product;
        private Integer productQuantity;

}
