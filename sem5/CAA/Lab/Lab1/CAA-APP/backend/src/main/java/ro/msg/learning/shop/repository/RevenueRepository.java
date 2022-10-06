package ro.msg.learning.shop.repository;

import org.springframework.data.repository.CrudRepository;
import ro.msg.learning.shop.entity.Revenue;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

public interface RevenueRepository extends CrudRepository<Revenue, Integer> {
    List<Revenue> findAllByDate(LocalDate date);
}
