package ro.msg.learning.shop.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.util.List;

@EqualsAndHashCode(callSuper = true)
@Entity
@Table(name = "supplier")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Supplier extends BaseEntity<Integer> {

    @Column(nullable = false)
    private String name;

    @OneToMany(mappedBy = "supplier", fetch = FetchType.EAGER)
    private List<Product> products;

}
