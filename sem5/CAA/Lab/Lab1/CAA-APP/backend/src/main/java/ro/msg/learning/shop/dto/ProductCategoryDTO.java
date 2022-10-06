package ro.msg.learning.shop.dto;

import lombok.Data;
import ro.msg.learning.shop.entity.Product;
import ro.msg.learning.shop.entity.ProductCategory;

import java.util.ArrayList;
import java.util.List;

@Data
public class ProductCategoryDTO {

    private Integer id;
    private String name;
    private String description;
    private List<ProductDTO> products = new ArrayList<>();

    public static ProductCategoryDTO ofEntity(ProductCategory productCategory) {

        ProductCategoryDTO productCategoryDTO = new ProductCategoryDTO();

        productCategoryDTO.setId(productCategory.getId());
        productCategoryDTO.setName(productCategory.getName());
        productCategoryDTO.setDescription(productCategory.getDescription());

        if(productCategory.getProducts() != null) {
            for (Product product: productCategory.getProducts()) {
                productCategoryDTO.getProducts().add(ProductDTO.ofEntity(product));
            }
        }

        return productCategoryDTO;
    }
}
