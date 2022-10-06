package ro.msg.learning.shop.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import ro.msg.learning.shop.entity.Stock;
import ro.msg.learning.shop.repository.StockRepository;

import java.util.List;

@RequiredArgsConstructor
@Service
public class StockManagementService {

    private final StockRepository stockRepository;

    public List<Stock> getStocksByLocationId(int locationId){
        return stockRepository.findAllByStockIdLocationId(locationId);
    }
}
