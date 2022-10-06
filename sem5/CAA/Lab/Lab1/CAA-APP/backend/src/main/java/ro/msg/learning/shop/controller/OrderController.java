package ro.msg.learning.shop.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import ro.msg.learning.shop.dto.OrderDTO;
import ro.msg.learning.shop.dto.OrderProductQuantityDTO;
import ro.msg.learning.shop.service.OrderManagementService;

import java.util.List;

@RestController
@RequiredArgsConstructor
public class OrderController {

    private final OrderManagementService orderService;

    @PostMapping(value = "/api/orders")
    public List<OrderDTO> createOrder(
            @AuthenticationPrincipal @RequestBody OrderProductQuantityDTO orderProductQuantityDTO) {
        return orderService.saveOrders(orderProductQuantityDTO);
    }
}
