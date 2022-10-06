package ro.msg.learning.shop.repository;

import org.springframework.data.repository.CrudRepository;
import ro.msg.learning.shop.entity.Location;

import java.util.List;
import java.util.Optional;

public interface LocationRepository extends CrudRepository<Location, Integer> {
    @Override
    List<Location> findAll();
}
