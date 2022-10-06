package ro.msg.learning.shop.dto;

import lombok.Data;
import ro.msg.learning.shop.entity.Location;
import ro.msg.learning.shop.entity.Order;
import ro.msg.learning.shop.entity.Revenue;

import java.util.ArrayList;
import java.util.List;

@Data
public class LocationDTO {

    private Integer id;
    private String name;
    private String addressCountry;
    private String addressCity;
    private String addressCounty;
    private String addressStreetAddress;
    private List<RevenueDTO> revenues = new ArrayList<>();
    private List<OrderDTO> orders = new ArrayList<>();

    public static LocationDTO ofEntity(Location location) {

        LocationDTO locationDTO = new LocationDTO();

        locationDTO.setId(location.getId());
        locationDTO.setAddressCity(location.getAddressCity());
        locationDTO.setAddressCountry(location.getAddressCountry());
        locationDTO.setAddressCounty(location.getAddressCounty());
        locationDTO.setAddressStreetAddress(location.getAddressStreetAddress());
        locationDTO.setName(location.getName());

//        if (location.getOrders() != null) {
//            for (Order order : location.getOrders()) {
//                locationDTO.getOrders().add(OrderDTO.ofEntity(order));
//            }
//        }

//        if (location.getRevenues() != null) {
//            for (Revenue revenue : location.getRevenues()) {
//                locationDTO.getRevenues().add(RevenueDTO.ofEntity(revenue));
//            }
//        }

        return locationDTO;
    }
}
