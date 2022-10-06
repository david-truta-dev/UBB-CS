package ro.msg.learning.shop.dto;

import lombok.Data;
import ro.msg.learning.shop.entity.Stock;

@Data
public class StockDTO {

    private StockIdDTO stockId;
    private String quantity;

    public static StockDTO ofEntity(Stock stock){

        StockDTO stockDTO = new StockDTO();

        StockIdDTO stockIdDTO = StockIdDTO.ofEntity(stock.getStockId());
        stockDTO.setStockId(stockIdDTO);
        stockDTO.setQuantity(Integer.toString(stock.getQuantity()));

        return stockDTO;
    }
}
