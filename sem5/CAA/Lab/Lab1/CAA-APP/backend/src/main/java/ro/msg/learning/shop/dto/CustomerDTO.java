package ro.msg.learning.shop.dto;

import lombok.Data;
import ro.msg.learning.shop.entity.Customer;
import ro.msg.learning.shop.entity.Order;

import java.util.ArrayList;
import java.util.List;

@Data
public class CustomerDTO {

    private Integer id;
    private String firstName;
    private String lastName;
    private String username;
    private String password;
    private String emailAddress;
    private List<OrderDTO> orders = new ArrayList<>();

    public static CustomerDTO ofEntity(Customer customer) {

        CustomerDTO customerDTO = new CustomerDTO();

        customerDTO.setId(customer.getId());
        customerDTO.setEmailAddress(customer.getEmailAddress());
        customerDTO.setFirstName(customer.getFirstName());
        customerDTO.setLastName(customer.getLastName());
        customerDTO.setUsername(customer.getUsername());
        customerDTO.setPassword(customer.getPassword());

        if (customer.getOrders() != null) {
            for (Order order : customer.getOrders()) {
                customerDTO.getOrders()
                           .add(OrderDTO.ofEntity(order));
            }
        }

        return customerDTO;
    }
}
