package ro.msg.learning.shop.dto;

import lombok.Data;
import ro.msg.learning.shop.entity.OrderDetail;

@Data
public class ProductAndQuantityDTO {

    private Integer id;
    private Integer quantity;

    public static ProductAndQuantityDTO ofEntity(OrderDetail orderDetail) {

        ProductAndQuantityDTO productAndQuantityDTO = new ProductAndQuantityDTO();

        productAndQuantityDTO.setId(orderDetail.getOrderDetailId()
                                               .getProductId());
        productAndQuantityDTO.setQuantity(orderDetail.getQuantity());

        return productAndQuantityDTO;
    }
}
