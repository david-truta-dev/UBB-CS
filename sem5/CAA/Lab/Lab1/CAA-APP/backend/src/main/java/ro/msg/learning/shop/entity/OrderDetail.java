package ro.msg.learning.shop.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Table;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "order_detail")
@Entity
public class OrderDetail {

    @EmbeddedId
    private OrderDetailId orderDetailId;

    @Column(name = "quantity", nullable = false)
    private Integer quantity;
}
