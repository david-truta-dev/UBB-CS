package ro.msg.learning.shop.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDate;

@EqualsAndHashCode(callSuper = true)
@Entity
@Table(name = "revenue")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Revenue extends BaseEntity<Integer>{

    @Column(nullable = false)
    private LocalDate date;

    @Column(nullable = false)
    private BigDecimal sum;

    @ManyToOne
    @JoinColumn( name = "location_id", nullable = false)
    private Location location;
}
