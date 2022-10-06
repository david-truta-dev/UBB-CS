package ro.msg.learning.shop.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import ro.msg.learning.shop.dto.ProductDTO;
import ro.msg.learning.shop.entity.Product;
import ro.msg.learning.shop.entity.ProductCategory;
import ro.msg.learning.shop.entity.Supplier;
import ro.msg.learning.shop.repository.ProductCategoryRepository;
import ro.msg.learning.shop.repository.ProductRepository;
import ro.msg.learning.shop.repository.SupplierRepository;

import javax.transaction.Transactional;
import java.math.BigDecimal;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ProductManagementService {
    private final ProductCategoryRepository productCategoryRepository;
    private final ProductRepository productRepository;
    private final SupplierRepository supplierRepository;

    @Transactional
    public ProductDTO addProduct(ProductDTO productDTO) {

        String name = productDTO.getName();
        String description = productDTO.getDescription();
        BigDecimal price = productDTO.getPrice();
        Double weight = productDTO.getWeight();
        ProductCategory category = productCategoryRepository.findById(productDTO.getCategoryId()).orElse(null);
        Supplier supplier = supplierRepository.findById(productDTO.getSupplierId()).orElse(null);
        String imageUrl = productDTO.getImageUrl();

        Product product = new Product(name, description, price, weight, category, supplier, imageUrl);
        return ProductDTO.ofEntity(productRepository.save(product));
    }

    @Transactional
    public void removeProduct(Integer productId) {
        Product product = productRepository.findById(productId).orElse(null);
        productRepository.delete(product);
    }

    @Transactional
    public List<ProductDTO> getProducts() {
        return productRepository.findAll()
                                .stream().map(ProductDTO::ofEntity).collect(Collectors.toList());
    }

    @Transactional
    public ProductDTO getProductById(Integer id) {
        return ProductDTO.ofEntity(Objects.requireNonNull(productRepository.findById(id).orElse(null)));
    }

    @Transactional
    public void updateProduct(int productId, ProductDTO productDTO) {

        Product product = new Product();
        ProductCategory category = productCategoryRepository.findById(productDTO.getCategoryId()).orElse(null);
        Supplier supplier = supplierRepository.findById(productDTO.getSupplierId()).orElse(null);

        product.setDescription(productDTO.getDescription());
        product.setImageUrl(productDTO.getImageUrl());
        product.setName(productDTO.getName());
        product.setPrice(productDTO.getPrice());
        product.setSupplier(supplier);
        product.setWeight(productDTO.getWeight());
        product.setId(productId);
        product.setCategory(category);

        productRepository.save(product);
    }
}
