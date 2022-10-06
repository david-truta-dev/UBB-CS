package ro.msg.learning.shop.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import ro.msg.learning.shop.dto.OrderDTO;
import ro.msg.learning.shop.dto.OrderProductQuantityDTO;
import ro.msg.learning.shop.entity.*;
import ro.msg.learning.shop.exception.CustomerNotFoundException;
import ro.msg.learning.shop.exception.InvalidOrderException;
import ro.msg.learning.shop.model.LocationStrategyModel;
import ro.msg.learning.shop.repository.*;
import ro.msg.learning.shop.strategy.StrategyInterface;

import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class OrderManagementService {

    private final StrategyInterface strategyInterface;
    private final OrderRepository orderRepository;
    private final StockRepository stockRepository;
    private final CustomerRepository customerRepository;
    private final OrderDetailRepository orderDetailRepository;

    @Transactional
    public Order addOrder(OrderProductQuantityDTO orderProductQuantityDTO,
                          Location location) {

        Order order = new Order();
        order.setAddressCity(orderProductQuantityDTO.getAddressCity());
        order.setAddressCountry(orderProductQuantityDTO.getAddressCountry());
        order.setAddressCounty(orderProductQuantityDTO.getAddressCounty());
        order.setAddressStreetAddress(
                orderProductQuantityDTO.getAddressStreetAddress());
        order.setShippedFrom(location);

        order.setCreatedAt(orderProductQuantityDTO.getCreatedAt());

        Customer customer = customerRepository.findById(
                orderProductQuantityDTO.getCustomerId())
                                              .orElseThrow(
                                                      CustomerNotFoundException::new);
        order.setCustomer(customer);

        order = orderRepository.save(order);

        return order;
    }

    @Transactional
    public List<OrderDTO> saveOrders(
            OrderProductQuantityDTO orderProductQuantityDTO) {
        if (orderProductQuantityDTO == null ||
                orderProductQuantityDTO.getCustomerId() == null ||
                orderProductQuantityDTO.getProducts().isEmpty()) {
            throw new InvalidOrderException();
        }

        Order order;
        List<OrderDTO> orders = new ArrayList<>();

        List<LocationStrategyModel> locationStrategyModelList = strategyInterface.getLocations(
                orderProductQuantityDTO);
        for (LocationStrategyModel locationStrategyModel : locationStrategyModelList) {

            Stock stock = stockRepository.findAll()
                                         .stream()
                                         .filter(s -> s.getStockId()
                                                       .getProductId()
                                                       .equals(locationStrategyModel.getProduct()
                                                                                    .getId()))
                                         .findFirst()
                                         .orElse(null);

            if (stock != null) {

                stock.setQuantity(
                        stock.getQuantity() - locationStrategyModel.getProductQuantity());
                stockRepository.save(stock);
            }

            order = addOrder(orderProductQuantityDTO,
                             locationStrategyModel.getLocation());
            OrderDetailId orderDetailId = new OrderDetailId(
                    locationStrategyModel.getProduct()
                                         .getId(), order.getId());
            OrderDetail orderDetail = new OrderDetail(orderDetailId,
                                                      locationStrategyModel.getProductQuantity());
            orderDetailRepository.save(orderDetail);

            orders.add(OrderDTO.ofEntity(order));
        }

        return orders;
    }
}
