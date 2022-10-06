package ro.msg.learning.shop.model;

import lombok.*;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;
import ro.msg.learning.shop.entity.Customer;

import java.util.Collection;

@Getter
@Setter
@ToString(callSuper = true)
@EqualsAndHashCode(callSuper = true)
public class CustomUser extends User {
    private Integer id;
    private String firstName;
    private String lastName;

    public CustomUser(Customer customer,
                      Collection<? extends GrantedAuthority> authorities) {
        super(customer.getUsername(), customer.getPassword(), authorities);
        this.firstName = customer.getFirstName();
        this.lastName = customer.getLastName();
        this.id = customer.getId();
    }
}
