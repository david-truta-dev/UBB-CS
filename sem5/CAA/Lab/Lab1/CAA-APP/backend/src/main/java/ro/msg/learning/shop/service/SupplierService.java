package ro.msg.learning.shop.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import ro.msg.learning.shop.dto.SupplierDTO;
import ro.msg.learning.shop.repository.SupplierRepository;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class SupplierService {
    private final SupplierRepository supplierRepository;

    public List<SupplierDTO> getSuppliers() {
        return supplierRepository.findAll()
                                 .stream()
                                 .map(SupplierDTO::ofEntity)
                                 .collect(Collectors.toList());
    }
}
