package ro.msg.learning.shop.dto;

import lombok.Data;
import ro.msg.learning.shop.entity.Order;

import java.time.format.DateTimeFormatter;

@Data
public class OrderDTO {

    private Integer id;
    private LocationDTO shippedFrom;
    private Integer customerId;
    private String createdAt;
    private String addressCountry;
    private String addressCity;
    private String addressCounty;
    private String addressStreetAddress;

    public static OrderDTO ofEntity(Order order) {

        OrderDTO orderDTO = new OrderDTO();
        orderDTO.setId(order.getId());
        orderDTO.setCustomerId(order.getCustomer().getId());
        orderDTO.setShippedFrom(LocationDTO.ofEntity(order.getShippedFrom()));
        orderDTO.setAddressCity(order.getAddressCity());
        orderDTO.setAddressCountry(order.getAddressCountry());
        orderDTO.setAddressStreetAddress(order.getAddressStreetAddress());
        orderDTO.setAddressCounty(order.getAddressCounty());

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        orderDTO.setCreatedAt(order.getCreatedAt().format(formatter));

        return orderDTO;
    }
}
