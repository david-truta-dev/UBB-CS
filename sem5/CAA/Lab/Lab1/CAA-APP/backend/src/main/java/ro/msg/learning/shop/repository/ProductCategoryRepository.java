package ro.msg.learning.shop.repository;

import org.springframework.data.repository.CrudRepository;
import ro.msg.learning.shop.entity.ProductCategory;

import java.util.List;

public interface ProductCategoryRepository extends CrudRepository<ProductCategory, Integer> {
    @Override
    List<ProductCategory> findAll();
}
