package ro.msg.learning.shop.dto;

import lombok.Data;
import ro.msg.learning.shop.entity.Product;

import java.math.BigDecimal;

@Data
public class ProductDTO {

    private Integer id;
    private String name;
    private String description;
    private BigDecimal price;
    private Double weight;
    private String categoryName;
    private String categoryDescription;
    private Integer categoryId;
    private Integer supplierId;
    private String imageUrl;

    public static ProductDTO ofEntity(Product product){

        ProductDTO productDTO = new ProductDTO();

        productDTO.setId(product.getId());
        productDTO.setName(product.getName());
        productDTO.setDescription(product.getDescription());
        productDTO.setPrice(product.getPrice());
        productDTO.setWeight(product.getWeight());
        productDTO.setCategoryName(product.getCategory().getName());
        productDTO.setCategoryDescription(product.getCategory().getDescription());
        productDTO.setCategoryId(product.getCategory().getId());
        productDTO.setSupplierId(product.getSupplier().getId());
        productDTO.setImageUrl(product.getImageUrl());

        return  productDTO;
    }
}
