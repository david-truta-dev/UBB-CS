package ro.msg.learning.shop.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.time.LocalDateTime;

@EqualsAndHashCode(callSuper = true)
@Entity
@Table(name = "order_table")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Order extends BaseEntity<Integer> {

    @ManyToOne
    @JoinColumn( name = "location_id", nullable = false)
    private Location shippedFrom;

    @ManyToOne
    @JoinColumn( name = "customer_id", nullable = false)
    private Customer customer;

    @Column(nullable = false)
    private LocalDateTime createdAt;

    @Column(nullable = false)
    private String addressCountry;

    @Column(nullable = false)
    private String addressCity;

    @Column(nullable = false)
    private String addressCounty;

    @Column(nullable = false)
    private String addressStreetAddress;

    @Override
    public String toString() {
        return "Order{" +
                "shippedFrom=" + shippedFrom.getName() +
                ", customer=" + customer.getFirstName() + " " + customer.getLastName() +
                ", createdAt=" + createdAt +
                ", addressCountry='" + addressCountry + '\'' +
                ", addressCity='" + addressCity + '\'' +
                ", addressCounty='" + addressCounty + '\'' +
                ", addressStreetAddress='" + addressStreetAddress + '\'' +
                '}';
    }
}
