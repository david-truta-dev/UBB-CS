package ro.msg.learning.shop.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import ro.msg.learning.shop.dto.RevenueDTO;
import ro.msg.learning.shop.service.RevenueManagementService;

import java.util.List;

@RestController
@RequiredArgsConstructor
public class RevenueController {

    private final RevenueManagementService revenueService;

    @GetMapping(value = "/api/revenues")
    public List<RevenueDTO> getRevenues(@AuthenticationPrincipal @RequestBody String date){
        return revenueService.getRevenuesForDate(date);
    }
}
