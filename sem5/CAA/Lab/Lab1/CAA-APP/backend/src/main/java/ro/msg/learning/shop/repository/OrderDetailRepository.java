package ro.msg.learning.shop.repository;

import org.springframework.data.repository.CrudRepository;
import ro.msg.learning.shop.entity.OrderDetail;
import ro.msg.learning.shop.entity.OrderDetailId;

import java.util.List;
import java.util.Optional;

public interface OrderDetailRepository extends CrudRepository<OrderDetail, OrderDetailId> {
    List<OrderDetail> findAllByOrderDetailIdOrderId(int orderId);
}
