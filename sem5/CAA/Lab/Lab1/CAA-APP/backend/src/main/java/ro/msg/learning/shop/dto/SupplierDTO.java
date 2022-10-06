package ro.msg.learning.shop.dto;

import lombok.Data;
import ro.msg.learning.shop.entity.Product;
import ro.msg.learning.shop.entity.Supplier;

import java.util.ArrayList;
import java.util.List;

@Data
public class SupplierDTO {

    private Integer id;
    private String name;
    private List<ProductDTO> products = new ArrayList<>();

    public static SupplierDTO ofEntity(Supplier supplier){

        SupplierDTO supplierDTO = new SupplierDTO();

        supplierDTO.setId(supplier.getId());
        supplierDTO.setName(supplier.getName());

        if(supplier.getProducts() != null){
            for (Product product: supplier.getProducts()) {
                supplierDTO.getProducts().add(ProductDTO.ofEntity(product));
            }
        }

        return supplierDTO;
    }
}
