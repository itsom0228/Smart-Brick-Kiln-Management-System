package com.dipaksarpane.kiln.service;

import com.dipaksarpane.kiln.entity.Order;
import com.dipaksarpane.kiln.entity.Product;
import com.dipaksarpane.kiln.repository.OrderRepository;
import com.dipaksarpane.kiln.repository.ProductRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.Random;

@Service
@Transactional
public class OrderService {

    private final OrderRepository orderRepository;
    private final ProductRepository productRepository;
    private final InventoryService inventoryService;
    private final SystemSettingService systemSettingService;

    public OrderService(OrderRepository orderRepository, 
                        ProductRepository productRepository, 
                        InventoryService inventoryService,
                        SystemSettingService systemSettingService) {
        this.orderRepository = orderRepository;
        this.productRepository = productRepository;
        this.inventoryService = inventoryService;
        this.systemSettingService = systemSettingService;
    }

    public List<Order> getAllOrders() {
        return orderRepository.findAllByOrderByOrderDateDesc();
    }

    public Optional<Order> getOrderById(Long id) {
        return orderRepository.findById(id);
    }

    public Optional<Order> getOrderByNumber(String orderNumber) {
        return orderRepository.findByOrderNumber(orderNumber);
    }

    public Optional<Order> trackOrder(String orderNumber, String mobileNumber) {
        return orderRepository.findForTracking(orderNumber.trim(), mobileNumber.trim());
    }

    public Order placeOrder(Order order) {
        // Find product
        Product product = productRepository.findById(order.getProduct().getId())
                .orElseThrow(() -> new IllegalArgumentException("Product not found"));

        order.setProduct(product);
        order.setProductTypeName(product.getName());
        order.setProductUnitPrice(product.getPrice());

        // Generate unique order number
        order.setOrderNumber(generateOrderNumber());

        // Calculate costs
        BigDecimal qty = BigDecimal.valueOf(order.getQuantity());
        BigDecimal productCost = product.getPrice().multiply(qty);
        
        // Fetch transport rate from settings
        BigDecimal transportRate = systemSettingService.getTransportRateStandard(); 
        if (product.getName().toLowerCase().contains("hollow")) {
            transportRate = systemSettingService.getTransportRateHollow(); // Hollow bricks are bulky
        }
        BigDecimal transportCost = transportRate.multiply(qty);

        // Fetch GST from settings
        BigDecimal gstRate = systemSettingService.getGstRate();
        BigDecimal gstAmount = productCost.multiply(gstRate).setScale(2, RoundingMode.HALF_UP);
        BigDecimal totalCost = productCost.add(gstAmount).add(transportCost).setScale(2, RoundingMode.HALF_UP);

        order.setProductCost(productCost);
        order.setGstAmount(gstAmount);
        order.setTransportCost(transportCost);
        order.setTotalCost(totalCost);

        order.setCurrentStatus("PENDING");
        order.setOrderDate(LocalDateTime.now());

        return orderRepository.save(order);
    }

    public Order updateOrderStatus(Long orderId, String newStatus) {
        Order order = orderRepository.findById(orderId)
                .orElseThrow(() -> new IllegalArgumentException("Order not found ID: " + orderId));

        String oldStatus = order.getCurrentStatus();
        order.setCurrentStatus(newStatus);

        // Auto Stock Deduction when order moves from PENDING to APPROVED (or other active state)
        if (oldStatus.equals("PENDING") && 
            (newStatus.equals("APPROVED") || newStatus.equals("PRODUCTION_STARTED") || newStatus.equals("READY_FOR_DISPATCH"))) {
            inventoryService.deductStockForOrder(
                order.getProduct(), 
                order.getQuantity(), 
                "Auto stock deduction for Order " + order.getOrderNumber()
            );
        }

        // Return stock if order is REJECTED from an approved status
        if (!oldStatus.equals("PENDING") && !oldStatus.equals("REJECTED") && newStatus.equals("REJECTED")) {
            inventoryService.addStock(
                order.getProduct().getId(), 
                order.getQuantity(), 
                "Stock restored. Order " + order.getOrderNumber() + " was REJECTED."
            );
        }

        return orderRepository.save(order);
    }

    public List<Order> searchOrders(String query) {
        if (query == null || query.trim().isEmpty()) {
            return getAllOrders();
        }
        return orderRepository.searchOrders(query.trim());
    }

    private String generateOrderNumber() {
        Random rand = new Random();
        int num = 100000 + rand.nextInt(900000); // 6 digit random number
        return "DSBI-" + num;
    }
}
