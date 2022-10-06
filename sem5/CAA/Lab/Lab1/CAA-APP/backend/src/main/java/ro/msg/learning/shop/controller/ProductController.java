package ro.msg.learning.shop.controller;


import lombok.RequiredArgsConstructor;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;
import ro.msg.learning.shop.dto.ProductDTO;
import ro.msg.learning.shop.service.ProductManagementService;

import java.util.List;

@RestController
@RequiredArgsConstructor
public class ProductController {

    private final ProductManagementService productService;

    @GetMapping("/api/products")
    public List<ProductDTO> getAllProducts() {

        return productService.getProducts();
    }

    @GetMapping("/api/products/{productId}")
    public ProductDTO getProductById(@AuthenticationPrincipal @PathVariable int productId) {

        return productService.getProductById(productId);
    }

    @DeleteMapping("/api/products/{productId}")
    public void removeProduct(@AuthenticationPrincipal @PathVariable int productId) {

        productService.removeProduct(productId);
    }

    @PostMapping("/api/products")
    public ProductDTO addProduct(@AuthenticationPrincipal @RequestBody ProductDTO productDTO) {

        return productService.addProduct(productDTO);
    }

    @PutMapping("/api/products/{productId}")
    public void updateProduct(@AuthenticationPrincipal @PathVariable int productId, @AuthenticationPrincipal @RequestBody ProductDTO productDTO) {

        productService.updateProduct(productId, productDTO);
    }
}

