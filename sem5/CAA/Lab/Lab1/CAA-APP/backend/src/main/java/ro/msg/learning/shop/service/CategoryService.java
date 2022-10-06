package ro.msg.learning.shop.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import ro.msg.learning.shop.dto.ProductCategoryDTO;
import ro.msg.learning.shop.repository.ProductCategoryRepository;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class CategoryService {
    private final ProductCategoryRepository productCategoryRepository;

    public List<ProductCategoryDTO> getCategories() {
        return productCategoryRepository.findAll()
                                        .stream()
                                        .map(ProductCategoryDTO::ofEntity)
                                        .collect(Collectors.toList());
    }
}
