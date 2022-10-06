package ro.msg.learning.shop.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@AllArgsConstructor
@Data
@NoArgsConstructor
class InfoResponseModel {

    private CopyRightModel info;
    private Integer statusCode;
    private List<String> messages;
}
