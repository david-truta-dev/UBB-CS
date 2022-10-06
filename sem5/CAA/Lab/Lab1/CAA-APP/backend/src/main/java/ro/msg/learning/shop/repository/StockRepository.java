package ro.msg.learning.shop.repository;

import org.springframework.data.repository.CrudRepository;
import ro.msg.learning.shop.entity.Stock;
import ro.msg.learning.shop.entity.StockId;

import java.util.List;
import java.util.Optional;

public interface StockRepository extends CrudRepository<Stock, StockId> {
    List<Stock> findAllByStockIdLocationId(int locationId);

    @Override
    List<Stock> findAll();
}
