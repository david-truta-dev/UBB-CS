package ro.msg.learning.shop.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

import javax.persistence.*;
import java.util.List;

@EqualsAndHashCode(callSuper = true)
@Entity
@Data
@Table(name = "location")
@AllArgsConstructor
@NoArgsConstructor
public class Location extends BaseEntity<Integer> {

    @Column(nullable = false)
    private String name;

    @Column(nullable = false)
    private String addressCountry;

    @Column(nullable = false)
    private String addressCity;

    @Column(nullable = false)
    private String addressCounty;

    @Column(nullable = false)
    private String addressStreetAddress;

    @OneToMany(mappedBy = "location", fetch = FetchType.EAGER)
    @Fetch(value = FetchMode.SUBSELECT)
    private List<Revenue> revenues;

    @OneToMany(mappedBy = "shippedFrom", fetch = FetchType.EAGER)
    @Fetch(value = FetchMode.SUBSELECT)
    private List<Order> orders;

    @Override
    public String toString() {
        return "Location{" +
                "name='" + name + '\'' +
                ", addressCountry='" + addressCountry + '\'' +
                ", addressCity='" + addressCity + '\'' +
                ", addressCounty='" + addressCounty + '\'' +
                ", addressStreetAddress='" + addressStreetAddress + '\'' +
                '}';
    }
}
