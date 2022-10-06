package ro.msg.learning.shop.dto;

import lombok.Data;
import ro.msg.learning.shop.entity.Order;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Data
public class OrderProductQuantityDTO {

    private Integer id;
    private Integer customerId;
    private LocalDateTime createdAt = LocalDateTime.now();
    private String addressCountry = "Romania";
    private String addressCity = "Cluj-Napoca";
    private String addressCounty = "Cluj";
    private String addressStreetAddress = "1 Mihail Kogalniceanu";
    private List<ProductAndQuantityDTO> products = new ArrayList<>();

    public static OrderProductQuantityDTO ofEntity(Order order,
                                                   List<ProductAndQuantityDTO> productAndQuantityDTOList) {

        OrderProductQuantityDTO orderProductQuantityDTO = new OrderProductQuantityDTO();
        orderProductQuantityDTO.setId(order.getId());

//        orderProductQuantityDTO.setAddressCity("Cluj-Napoca");
//        orderProductQuantityDTO.setAddressCountry("Romania");
//        orderProductQuantityDTO.setAddressStreetAddress("1");
//        orderProductQuantityDTO.setAddressCounty("Cluj");
        orderProductQuantityDTO.setProducts(productAndQuantityDTOList);
        orderProductQuantityDTO.setCustomerId(order.getCustomer()
                                                   .getId());

//        orderProductQuantityDTO.setCreatedAt(LocalDateTime.now());

        return orderProductQuantityDTO;
    }
}
