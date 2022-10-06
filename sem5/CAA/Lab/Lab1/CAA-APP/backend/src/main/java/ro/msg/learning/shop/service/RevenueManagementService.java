package ro.msg.learning.shop.service;

import lombok.RequiredArgsConstructor;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import ro.msg.learning.shop.dto.RevenueDTO;
import ro.msg.learning.shop.entity.Location;
import ro.msg.learning.shop.entity.Order;
import ro.msg.learning.shop.entity.Revenue;
import ro.msg.learning.shop.repository.*;

import javax.transaction.Transactional;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class RevenueManagementService {

    private final RevenueRepository revenueRepository;
    private final LocationRepository locationRepository;
    private final OrderRepository orderRepository;
    private final OrderDetailRepository orderDetailRepository;
    private final ProductRepository productRepository;

    public List<RevenueDTO> getRevenuesForDate(String date) {

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDate localDate = LocalDate.parse(date, formatter);
        List<RevenueDTO> revenueDTOList = new ArrayList<>();

        List<Revenue> revenuesByDate = revenueRepository.findAllByDate(localDate);
        revenuesByDate.forEach(revenue ->
                revenueDTOList.add(RevenueDTO.ofEntity(revenue)));

        return revenueDTOList;
    }

    @Scheduled(cron = "59 59 23 * * ?")
    @Transactional
    public void aggregateSales() {

        List<Location> locations = locationRepository.findAll();
        LocalDate endOfDay = LocalDateTime.now().toLocalDate();

        locations.forEach(location -> {

                    List<Order> orders = orderRepository
                            .findAllByShippedFrom(location).stream()
                            .filter(order -> order.getCreatedAt().toLocalDate().equals(endOfDay))
                            .collect(Collectors.toList());

                    final BigDecimal[] totalSum = {new BigDecimal(0)};

                    orders.stream().map(order -> orderDetailRepository.findAllByOrderDetailIdOrderId(order.getId()))
                            .forEach(orderDetails -> orderDetails.forEach(orderDetail -> {
                                        productRepository.findById(orderDetail.getOrderDetailId().getProductId()).ifPresent(product ->
                                                totalSum[0] = totalSum[0].add(product.getPrice().multiply(new BigDecimal(orderDetail.getQuantity())))
                                        );
                                    })
                            );

                    revenueRepository.save(new Revenue(endOfDay, totalSum[0], location));
                }
        );
    }
}