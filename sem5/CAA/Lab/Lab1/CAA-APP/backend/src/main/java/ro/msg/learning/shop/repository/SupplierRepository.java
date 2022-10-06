package ro.msg.learning.shop.repository;

import org.springframework.data.repository.CrudRepository;
import ro.msg.learning.shop.entity.Product;
import ro.msg.learning.shop.entity.Supplier;

import java.util.List;

public interface SupplierRepository extends CrudRepository<Supplier, Integer> {
    @Override
    List<Supplier> findAll();
}
