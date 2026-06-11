package com.dipaksarpane.kiln.controller.api;

import com.dipaksarpane.kiln.entity.*;
import com.dipaksarpane.kiln.repository.ContactMessageRepository;
import com.dipaksarpane.kiln.repository.ReviewRepository;
import com.dipaksarpane.kiln.service.OrderService;
import com.dipaksarpane.kiln.service.ProductService;
import com.dipaksarpane.kiln.service.QuotationService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/api")
public class AppApiController {

    private final OrderService orderService;
    private final QuotationService quotationService;
    private final ProductService productService;
    private final ReviewRepository reviewRepository;
    private final ContactMessageRepository contactMessageRepository;

    public AppApiController(OrderService orderService, 
                              QuotationService quotationService, 
                              ProductService productService, 
                              ReviewRepository reviewRepository, 
                              ContactMessageRepository contactMessageRepository) {
        this.orderService = orderService;
        this.quotationService = quotationService;
        this.productService = productService;
        this.reviewRepository = reviewRepository;
        this.contactMessageRepository = contactMessageRepository;
    }

    // 1. Get all products (useful for dynamic frontend calls)
    @GetMapping("/products")
    public ResponseEntity<List<Product>> getProducts() {
        return ResponseEntity.ok(productService.getAllProducts());
    }

    // 2. Submit order
    @PostMapping("/orders")
    public ResponseEntity<Map<String, Object>> submitOrder(@RequestBody Order order) {
        Map<String, Object> response = new HashMap<>();
        try {
            if (order.getProduct() == null || order.getProduct().getId() == null) {
                response.put("success", false);
                response.put("message", "Product selection is required.");
                return ResponseEntity.badRequest().body(response);
            }
            Order savedOrder = orderService.placeOrder(order);
            response.put("success", true);
            response.put("orderNumber", savedOrder.getOrderNumber());
            response.put("message", "Order placed successfully!");
            return ResponseEntity.status(HttpStatus.CREATED).body(response);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Failed to place order: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }

    // 3. Track order
    @GetMapping("/orders/track")
    public ResponseEntity<Map<String, Object>> trackOrder(@RequestParam String orderNumber, @RequestParam String mobileNumber) {
        Map<String, Object> response = new HashMap<>();
        Optional<Order> orderOpt = orderService.trackOrder(orderNumber, mobileNumber);
        if (orderOpt.isPresent()) {
            Order order = orderOpt.get();
            response.put("success", true);
            response.put("orderNumber", order.getOrderNumber());
            response.put("fullName", order.getFullName());
            response.put("productTypeName", order.getProductTypeName());
            response.put("quantity", order.getQuantity());
            response.put("deliveryDate", order.getDeliveryDate().toString());
            response.put("currentStatus", order.getCurrentStatus());
            response.put("statusProgress", order.getStatusProgress());
            response.put("totalCost", order.getTotalCost());
            return ResponseEntity.ok(response);
        } else {
            response.put("success", false);
            response.put("message", "Order not found or mobile number mismatch.");
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(response);
        }
    }

    // 4. Submit quotation request
    @PostMapping("/quotations")
    public ResponseEntity<Map<String, Object>> submitQuotation(@RequestBody Quotation quotation) {
        Map<String, Object> response = new HashMap<>();
        try {
            if (quotation.getProduct() == null || quotation.getProduct().getId() == null) {
                response.put("success", false);
                response.put("message", "Product selection is required.");
                return ResponseEntity.badRequest().body(response);
            }
            Quotation savedQuotation = quotationService.requestQuotation(quotation);
            response.put("success", true);
            response.put("quotationNumber", savedQuotation.getQuotationNumber());
            response.put("message", "Quotation requested successfully!");
            return ResponseEntity.status(HttpStatus.CREATED).body(response);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Failed to request quotation: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }

    // 5. Submit contact message / enquiry
    @PostMapping("/enquiries")
    public ResponseEntity<Map<String, Object>> submitEnquiry(@RequestBody ContactMessage message) {
        Map<String, Object> response = new HashMap<>();
        try {
            message.setCreatedDate(LocalDateTime.now());
            message.setReplied(false);
            contactMessageRepository.save(message);
            response.put("success", true);
            response.put("message", "Enquiry submitted successfully!");
            return ResponseEntity.status(HttpStatus.CREATED).body(response);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Failed to submit enquiry: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }

    // 6. Submit customer review
    @PostMapping("/reviews")
    public ResponseEntity<Map<String, Object>> submitReview(@RequestBody Review review) {
        Map<String, Object> response = new HashMap<>();
        try {
            review.setCreatedDate(LocalDateTime.now());
            review.setApproved(false); // Moderation required
            reviewRepository.save(review);
            response.put("success", true);
            response.put("message", "Review submitted successfully! It will be visible after admin approval.");
            return ResponseEntity.status(HttpStatus.CREATED).body(response);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Failed to submit review: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }
}
