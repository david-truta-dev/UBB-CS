package ro.msg.learning.shop.dto;

import lombok.Data;
import ro.msg.learning.shop.entity.Revenue;

import java.math.BigDecimal;
import java.time.format.DateTimeFormatter;

@Data
public class RevenueDTO {

    private Integer id;
    private String date;
    private BigDecimal sum;
    private Integer locationId;

    public static RevenueDTO ofEntity(Revenue revenue){

        RevenueDTO revenueDTO = new RevenueDTO();

        revenueDTO.setId(revenue.getId());
        revenueDTO.setSum(revenue.getSum());
        revenueDTO.setLocationId(revenue.getLocation().getId());

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        revenueDTO.setDate(revenue.getDate().format(formatter));

        return revenueDTO;
    }
}
