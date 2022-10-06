package ro.msg.learning.shop.dto;

import lombok.Data;
import ro.msg.learning.shop.entity.StockId;

@Data
public class StockIdDTO {

    private String locationId;
    private String productId;

    public static StockIdDTO ofEntity(StockId stockId) {

        StockIdDTO stockIdDTO = new StockIdDTO();
        stockIdDTO.setLocationId(Integer.toString(stockId.getLocationId()));
        stockIdDTO.setProductId(Integer.toString(stockId.getProductId()));

        return stockIdDTO;
    }
}
