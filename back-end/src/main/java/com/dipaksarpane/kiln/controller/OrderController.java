package com.dipaksarpane.kiln.controller;

import com.dipaksarpane.kiln.entity.Order;
import com.dipaksarpane.kiln.entity.Product;
import com.dipaksarpane.kiln.service.OrderService;
import com.dipaksarpane.kiln.service.ProductService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/order")
public class OrderController {

    private final OrderService orderService;
    private final ProductService productService;

    public OrderController(OrderService orderService, ProductService productService) {
        this.orderService = orderService;
        this.productService = productService;
    }

    @GetMapping("/now")
    public String orderNow(Model model, @RequestParam(value = "productId", required = false) Long productId) {
        List<Product> products = productService.getAllProducts();
        model.addAttribute("products", products);
        
        Order order = new Order();
        if (productId != null) {
            productService.getProductById(productId).ifPresent(order::setProduct);
        }
        model.addAttribute("order", order);
        return "order-now";
    }

    @PostMapping("/submit")
    public String submitOrder(@ModelAttribute Order order, RedirectAttributes redirect) {
        try {
            Order savedOrder = orderService.placeOrder(order);
            return "redirect:/order/success/" + savedOrder.getOrderNumber();
        } catch (Exception e) {
            redirect.addFlashAttribute("errorMessage", "Failed to place order: " + e.getMessage());
            return "redirect:/order/now";
        }
    }

    @GetMapping("/success/{orderNumber}")
    public String orderSuccess(@PathVariable String orderNumber, Model model) {
        Optional<Order> order = orderService.getOrderByNumber(orderNumber);
        if (order.isPresent()) {
            model.addAttribute("order", order.get());
            return "order-success";
        }
        return "redirect:/";
    }

    @GetMapping("/track")
    public String trackPage(Model model) {
        return "track";
    }

    @RequestMapping(value = "/track/search", method = {RequestMethod.GET, RequestMethod.POST})
    public String trackSearch(@RequestParam(value = "orderNumber", required = false) String orderNumber,
                              @RequestParam(value = "mobileNumber", required = false) String mobileNumber,
                              Model model) {
        if (orderNumber != null && mobileNumber != null) {
            Optional<Order> order = orderService.trackOrder(orderNumber, mobileNumber);
            if (order.isPresent()) {
                model.addAttribute("order", order.get());
                model.addAttribute("found", true);
            } else {
                model.addAttribute("error", "Order not found or mobile number mismatch.");
                model.addAttribute("found", false);
            }
            model.addAttribute("orderNumber", orderNumber);
            model.addAttribute("mobileNumber", mobileNumber);
        }
        return "track";
    }
}
