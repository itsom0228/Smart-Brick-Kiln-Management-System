package com.dipaksarpane.kiln.controller.api;

import com.dipaksarpane.kiln.entity.Order;
import com.dipaksarpane.kiln.entity.Product;
import com.dipaksarpane.kiln.entity.Quotation;
import com.dipaksarpane.kiln.service.InventoryService;
import com.dipaksarpane.kiln.service.OrderService;
import com.dipaksarpane.kiln.service.ProductService;
import com.dipaksarpane.kiln.service.QuotationService;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/admin/api")
public class AdminApiController {

    private final ProductService productService;
    private final InventoryService inventoryService;
    private final OrderService orderService;
    private final QuotationService quotationService;

    public AdminApiController(ProductService productService,
                              InventoryService inventoryService,
                              OrderService orderService,
                              QuotationService quotationService) {
        this.productService = productService;
        this.inventoryService = inventoryService;
        this.orderService = orderService;
        this.quotationService = quotationService;
    }

    // 1. SAVE PRODUCT (Create or Update)
    @PostMapping("/products/save")
    public ResponseEntity<Map<String, Object>> saveProduct(@RequestBody Product product) {
        Map<String, Object> response = new HashMap<>();
        try {
            if (product.getImageUrl() == null || product.getImageUrl().trim().isEmpty()) {
                String name = product.getName().toLowerCase();
                if (name.contains("red")) product.setImageUrl("/images/red-bricks.jpg");
                else if (name.contains("fly")) product.setImageUrl("/images/flyash-bricks.jpg");
                else if (name.contains("hollow")) product.setImageUrl("/images/hollow-bricks.jpg");
                else if (name.contains("concrete")) product.setImageUrl("/images/concrete-blocks.jpg");
                else product.setImageUrl("/images/paver-blocks.jpg");
            }
            Product saved = productService.saveProduct(product);
            response.put("success", true);
            response.put("product", saved);
            response.put("message", "Product saved successfully!");
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Failed to save product: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }

    // 2. DELETE PRODUCT
    @DeleteMapping("/products/delete/{id}")
    public ResponseEntity<Map<String, Object>> deleteProduct(@PathVariable Long id) {
        Map<String, Object> response = new HashMap<>();
        try {
            productService.deleteProduct(id);
            response.put("success", true);
            response.put("message", "Product deleted successfully!");
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Cannot delete product. It is referenced in active orders/quotes.");
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
        }
    }

    // 3. INVENTORY ADJUSTMENT
    @PostMapping("/inventory/adjust")
    public ResponseEntity<Map<String, Object>> adjustStock(@RequestBody Map<String, Object> payload) {
        Map<String, Object> response = new HashMap<>();
        try {
            Long productId = Long.valueOf(payload.get("productId").toString());
            Integer quantity = Integer.valueOf(payload.get("quantity").toString());
            String action = payload.get("action").toString();
            String remarks = payload.get("remarks") != null ? payload.get("remarks").toString() : "";

            if (action.equalsIgnoreCase("ADD")) {
                inventoryService.addStock(productId, quantity, remarks);
                response.put("message", "Stock added successfully!");
            } else {
                inventoryService.exitStock(productId, quantity, remarks);
                response.put("message", "Stock removed successfully!");
            }
            response.put("success", true);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Adjustment failed: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
        }
    }

    // 4. ORDER UPDATE STATUS
    @PostMapping("/orders/update-status/{id}")
    public ResponseEntity<Map<String, Object>> updateOrderStatus(@PathVariable Long id, @RequestParam String status) {
        Map<String, Object> response = new HashMap<>();
        try {
            orderService.updateOrderStatus(id, status);
            response.put("success", true);
            response.put("message", "Order status updated to " + status);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Failed to update order status: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
        }
    }

    // 5. QUOTATION UPDATE ESTIMATES
    @PostMapping("/quotations/update-estimates/{id}")
    public ResponseEntity<Map<String, Object>> updateQuotationEstimates(@PathVariable Long id,
                                                                        @RequestBody Map<String, Object> payload) {
        Map<String, Object> response = new HashMap<>();
        try {
            BigDecimal productCost = new BigDecimal(payload.get("productCost").toString());
            BigDecimal gstAmount = new BigDecimal(payload.get("gstAmount").toString());
            BigDecimal transportCost = new BigDecimal(payload.get("transportCost").toString());

            quotationService.updateQuotationEstimates(id, productCost, gstAmount, transportCost);
            response.put("success", true);
            response.put("message", "Quotation estimates updated successfully!");
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Failed to update quotation estimates: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
        }
    }

    // 6. CONVERT QUOTATION TO ORDER
    @PostMapping("/quotations/convert/{id}")
    public ResponseEntity<Map<String, Object>> convertQuotation(@PathVariable Long id,
                                                                @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate deliveryDate) {
        Map<String, Object> response = new HashMap<>();
        try {
            Order order = quotationService.convertQuotationToOrder(id, deliveryDate);
            response.put("success", true);
            response.put("orderNumber", order.getOrderNumber());
            response.put("orderId", order.getId());
            response.put("message", "Quotation converted to Order successfully!");
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Failed to convert quotation: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
        }
    }
}
