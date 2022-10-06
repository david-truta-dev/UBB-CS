package ro.msg.learning.shop.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import ro.msg.learning.shop.dto.LocationDTO;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class DistanceResponseModel {

    private boolean allToAll;
    private List<Long> distance;
    private List<Long> time;
    private LocationDTO locationDTO;
    private boolean manyToOne;
    private InfoResponseModel info;
}
