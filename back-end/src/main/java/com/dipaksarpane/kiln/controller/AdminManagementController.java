package com.dipaksarpane.kiln.controller;

import com.dipaksarpane.kiln.entity.*;
import com.dipaksarpane.kiln.repository.InventoryTransactionRepository;
import com.dipaksarpane.kiln.repository.OrderRepository;
import com.dipaksarpane.kiln.repository.ProductRepository;
import com.dipaksarpane.kiln.repository.QuotationRepository;
import com.dipaksarpane.kiln.service.*;
import org.springframework.core.io.InputStreamResource;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import java.io.ByteArrayInputStream;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.Map;

@Controller
@RequestMapping("/admin")
public class AdminManagementController {

    private final ProductService productService;
    private final InventoryService inventoryService;
    private final OrderService orderService;
    private final QuotationService quotationService;
    private final InvoiceService invoiceService;
    private final ReportService reportService;
    private final SystemSettingService systemSettingService;
    
    private final OrderRepository orderRepository;
    private final QuotationRepository quotationRepository;
    private final InventoryTransactionRepository transactionRepository;
    private final com.dipaksarpane.kiln.repository.GalleryImageRepository galleryImageRepository;

    public AdminManagementController(ProductService productService,
                                     InventoryService inventoryService,
                                     OrderService orderService,
                                     QuotationService quotationService,
                                     InvoiceService invoiceService,
                                     ReportService reportService,
                                     SystemSettingService systemSettingService,
                                     OrderRepository orderRepository,
                                     QuotationRepository quotationRepository,
                                     InventoryTransactionRepository transactionRepository,
                                     com.dipaksarpane.kiln.repository.GalleryImageRepository galleryImageRepository) {
        this.productService = productService;
        this.inventoryService = inventoryService;
        this.orderService = orderService;
        this.quotationService = quotationService;
        this.invoiceService = invoiceService;
        this.reportService = reportService;
        this.systemSettingService = systemSettingService;
        this.orderRepository = orderRepository;
        this.quotationRepository = quotationRepository;
        this.transactionRepository = transactionRepository;
        this.galleryImageRepository = galleryImageRepository;
    }

    // 1. PRODUCT CRUD MANAGEMENT
    @GetMapping("/products")
    public String listProducts(Model model) {
        model.addAttribute("products", productService.getAllProducts());
        return "admin/products";
    }

    @GetMapping("/products/add")
    public String addProductForm(Model model) {
        model.addAttribute("product", new Product());
        return "admin/product-form";
    }

    @GetMapping("/products/edit/{id}")
    public String editProductForm(@PathVariable Long id, Model model) {
        Optional<Product> p = productService.getProductById(id);
        if (p.isPresent()) {
            model.addAttribute("product", p.get());
            return "admin/product-form";
        }
        return "redirect:/admin/products";
    }

    @PostMapping("/products/save")
    public String saveProduct(@ModelAttribute Product product, RedirectAttributes redirect) {
        if (product.getImageUrl() == null || product.getImageUrl().trim().isEmpty()) {
            // Set mock default image based on names
            String name = product.getName().toLowerCase();
            if (name.contains("red")) product.setImageUrl("/images/red-bricks.jpg");
            else if (name.contains("fly")) product.setImageUrl("/images/flyash-bricks.jpg");
            else if (name.contains("hollow")) product.setImageUrl("/images/hollow-bricks.jpg");
            else if (name.contains("concrete")) product.setImageUrl("/images/concrete-blocks.jpg");
            else product.setImageUrl("/images/paver-blocks.jpg");
        }
        try {
            productService.saveProduct(product);
            redirect.addFlashAttribute("successMessage", "Product saved successfully!");
            return "redirect:/admin/products";
        } catch (org.springframework.dao.DataIntegrityViolationException e) {
            redirect.addFlashAttribute("errorMessage", "Error: A product with this Name or Code already exists in the database.");
            if (product.getId() != null) {
                return "redirect:/admin/products/edit/" + product.getId();
            } else {
                return "redirect:/admin/products/add";
            }
        } catch (Exception e) {
            redirect.addFlashAttribute("errorMessage", "An unexpected error occurred: " + e.getMessage());
            if (product.getId() != null) {
                return "redirect:/admin/products/edit/" + product.getId();
            } else {
                return "redirect:/admin/products/add";
            }
        }
    }

    @PostMapping("/products/delete/{id}")
    public String deleteProduct(@PathVariable Long id, RedirectAttributes redirect) {
        try {
            productService.deleteProduct(id);
            redirect.addFlashAttribute("successMessage", "Product deleted successfully!");
        } catch (Exception e) {
            redirect.addFlashAttribute("errorMessage", "Cannot delete product. It is referenced in active orders/quotes.");
        }
        return "redirect:/admin/products";
    }

    // 2. INVENTORY ADJUSTMENTS
    @GetMapping("/inventory")
    public String listInventory(Model model) {
        model.addAttribute("products", productService.getAllProducts());
        model.addAttribute("transactions", inventoryService.getAllTransactions());
        return "admin/inventory";
    }

    @PostMapping("/inventory/adjust")
    public String adjustStock(@RequestParam("productId") Long productId,
                              @RequestParam("quantity") Integer quantity,
                              @RequestParam("action") String action,
                              @RequestParam("remarks") String remarks,
                              RedirectAttributes redirect) {
        try {
            if (action.equalsIgnoreCase("ADD")) {
                inventoryService.addStock(productId, quantity, remarks);
                redirect.addFlashAttribute("successMessage", "Stock added successfully!");
            } else {
                inventoryService.exitStock(productId, quantity, remarks);
                redirect.addFlashAttribute("successMessage", "Stock removed successfully!");
            }
        } catch (Exception e) {
            redirect.addFlashAttribute("errorMessage", "Adjustment failed: " + e.getMessage());
        }
        return "redirect:/admin/inventory";
    }

    // 3. ORDER MANAGEMENT
    @GetMapping("/orders")
    public String listOrders(@RequestParam(value = "search", required = false) String search,
                             @RequestParam(value = "status", required = false) String status,
                             Model model) {
        List<Order> orders = orderService.searchOrders(search);
        if (status != null && !status.trim().isEmpty() && !status.equalsIgnoreCase("ALL")) {
            orders = orders.stream()
                    .filter(o -> o.getCurrentStatus().equalsIgnoreCase(status))
                    .toList();
        }
        model.addAttribute("orders", orders);
        model.addAttribute("search", search);
        model.addAttribute("status", status);
        return "admin/orders";
    }

    @GetMapping("/orders/view/{id}")
    public String viewOrder(@PathVariable Long id, Model model) {
        Optional<Order> order = orderService.getOrderById(id);
        if (order.isPresent()) {
            model.addAttribute("order", order.get());
            // Fetch or create invoice preview data
            Optional<Invoice> invoice = invoiceService.getInvoiceByOrderId(id);
            model.addAttribute("invoice", invoice.orElse(null));
            return "admin/order-detail";
        }
        return "redirect:/admin/orders";
    }

    @PostMapping("/orders/update-status/{id}")
    public String updateOrderStatus(@PathVariable Long id,
                                    @RequestParam("status") String status,
                                    RedirectAttributes redirect) {
        try {
            orderService.updateOrderStatus(id, status);
            redirect.addFlashAttribute("successMessage", "Order status updated to " + status);
        } catch (Exception e) {
            redirect.addFlashAttribute("errorMessage", "Failed to update order status: " + e.getMessage());
        }
        return "redirect:/admin/orders/view/" + id;
    }

    @GetMapping("/orders/invoice/download/{id}")
    public ResponseEntity<InputStreamResource> downloadInvoice(@PathVariable Long id,
                                                                @RequestParam(value = "gst", required = false) String gst) {
        Invoice invoice = invoiceService.generateOrGetInvoice(id, gst);
        ByteArrayInputStream bis = invoiceService.generateInvoicePdf(invoice);

        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Disposition", "attachment; filename=" + invoice.getInvoiceNumber() + ".pdf");

        return ResponseEntity
                .ok()
                .headers(headers)
                .contentType(MediaType.APPLICATION_PDF)
                .body(new InputStreamResource(bis));
    }

    // 4. QUOTATION MANAGEMENT
    @GetMapping("/quotations")
    public String listQuotations(Model model) {
        model.addAttribute("quotations", quotationService.getAllQuotations());
        return "admin/quotations";
    }

    @PostMapping("/quotations/update-estimates/{id}")
    public String updateQuotationEstimates(@PathVariable Long id,
                                           @RequestParam("productCost") BigDecimal productCost,
                                           @RequestParam("gstAmount") BigDecimal gstAmount,
                                           @RequestParam("transportCost") BigDecimal transportCost,
                                           RedirectAttributes redirect) {
        try {
            quotationService.updateQuotationEstimates(id, productCost, gstAmount, transportCost);
            redirect.addFlashAttribute("successMessage", "Quotation estimates updated successfully!");
        } catch (Exception e) {
            redirect.addFlashAttribute("errorMessage", "Failed to update quotation estimates: " + e.getMessage());
        }
        return "redirect:/admin/quotations";
    }

    @PostMapping("/quotations/convert/{id}")
    public String convertQuotation(@PathVariable Long id,
                                   @RequestParam(value = "deliveryDate", required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate deliveryDate,
                                   RedirectAttributes redirect) {
        try {
            Order order = quotationService.convertQuotationToOrder(id, deliveryDate);
            redirect.addFlashAttribute("successMessage", "Quotation converted to Order: " + order.getOrderNumber());
            return "redirect:/admin/orders/view/" + order.getId();
        } catch (Exception e) {
            redirect.addFlashAttribute("errorMessage", "Failed to convert quotation: " + e.getMessage());
            return "redirect:/admin/quotations";
        }
    }

    @GetMapping("/quotations/download/{id}")
    public ResponseEntity<InputStreamResource> downloadQuotation(@PathVariable Long id) {
        Quotation quote = quotationService.getQuotationById(id)
                .orElseThrow(() -> new IllegalArgumentException("Quotation not found"));
        ByteArrayInputStream bis = invoiceService.generateQuotationPdf(quote);

        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Disposition", "attachment; filename=" + quote.getQuotationNumber() + ".pdf");

        return ResponseEntity
                .ok()
                .headers(headers)
                .contentType(MediaType.APPLICATION_PDF)
                .body(new InputStreamResource(bis));
    }

    // 5. REPORTS DASHBOARD & EXPORTS
    @GetMapping("/reports")
    public String viewReports(Model model) {
        model.addAttribute("today", LocalDate.now().toString());
        model.addAttribute("lastMonth", LocalDate.now().minusMonths(1).toString());
        return "admin/reports";
    }

    @GetMapping("/reports/export")
    public ResponseEntity<InputStreamResource> exportReport(@RequestParam("type") String type,
                                                             @RequestParam("start") String startStr,
                                                             @RequestParam("end") String endStr) {
        LocalDateTime start = LocalDate.parse(startStr).atStartOfDay();
        LocalDateTime end = LocalDate.parse(endStr).atTime(23, 59, 59);

        ByteArrayInputStream bis;
        String filename;

        if (type.equalsIgnoreCase("orders")) {
            List<Order> orders = orderRepository.findOrdersBetweenDates(start, end);
            bis = reportService.exportOrdersToExcel(orders);
            filename = "orders_report_" + LocalDate.now() + ".xlsx";
        } else if (type.equalsIgnoreCase("inventory")) {
            List<InventoryTransaction> txs = transactionRepository.findTransactionsBetweenDates(start, end);
            bis = reportService.exportInventoryToExcel(txs);
            filename = "inventory_report_" + LocalDate.now() + ".xlsx";
        } else {
            List<Quotation> quotes = quotationRepository.findQuotationsBetweenDates(start, end);
            bis = reportService.exportQuotationsToExcel(quotes);
            filename = "quotations_report_" + LocalDate.now() + ".xlsx";
        }

        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Disposition", "attachment; filename=" + filename);

        return ResponseEntity
                .ok()
                .headers(headers)
                .contentType(MediaType.parseMediaType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"))
                .body(new InputStreamResource(bis));
    }

    // 6. DYNAMIC GALLERY IMAGE MANAGEMENT
    @GetMapping("/gallery")
    public String viewGallery(Model model) {
        model.addAttribute("images", galleryImageRepository.findAllByOrderByUploadDateDesc());
        return "admin/gallery";
    }

    @PostMapping("/gallery/upload")
    public String uploadGalleryImage(@RequestParam("title") String title,
                                     @RequestParam("imageFile") org.springframework.web.multipart.MultipartFile file,
                                     RedirectAttributes redirect) {
        try {
            if (file.isEmpty()) {
                redirect.addFlashAttribute("errorMessage", "Please select a file to upload.");
                return "redirect:/admin/gallery";
            }
            
            String contentType = file.getContentType();
            if (contentType == null || (!contentType.startsWith("image/jpeg") && !contentType.startsWith("image/png") && !contentType.startsWith("image/jpg"))) {
                redirect.addFlashAttribute("errorMessage", "Only JPEG, JPG, and PNG files are supported.");
                return "redirect:/admin/gallery";
            }

            byte[] bytes = file.getBytes();
            String base64Image = java.util.Base64.getEncoder().encodeToString(bytes);
            String prefix = "data:" + contentType + ";base64,";
            
            com.dipaksarpane.kiln.entity.GalleryImage image = new com.dipaksarpane.kiln.entity.GalleryImage();
            image.setTitle(title);
            image.setBase64Data(prefix + base64Image);
            image.setUploadDate(LocalDateTime.now());
            
            galleryImageRepository.save(image);
            redirect.addFlashAttribute("successMessage", "Image uploaded to gallery successfully!");
        } catch (Exception e) {
            redirect.addFlashAttribute("errorMessage", "Upload failed: " + e.getMessage());
        }
        return "redirect:/admin/gallery";
    }

    @PostMapping("/gallery/delete/{id}")
    public String deleteGalleryImage(@PathVariable Long id, RedirectAttributes redirect) {
        try {
            galleryImageRepository.deleteById(id);
            redirect.addFlashAttribute("successMessage", "Image deleted from gallery successfully!");
        } catch (Exception e) {
            redirect.addFlashAttribute("errorMessage", "Failed to delete image: " + e.getMessage());
        }
        return "redirect:/admin/gallery";
    }

    // 7. WEATHER FORECAST AND KILN ADVISORY
    @GetMapping("/weather")
    public String viewWeatherForecast(Model model) {
        model.addAttribute("forecast", generateWeatherForecast());
        return "admin/weather";
    }

    private List<WeatherDay> generateWeatherForecast() {
        java.util.ArrayList<WeatherDay> list = new java.util.ArrayList<>();
        LocalDate today = LocalDate.now();
        
        for (int i = 0; i < 15; i++) {
            LocalDate day = today.plusDays(i);
            String dateStr = day.format(java.time.format.DateTimeFormatter.ofPattern("dd MMM"));
            String dayOfWeek = day.getDayOfWeek().getDisplayName(java.time.format.TextStyle.SHORT, java.util.Locale.ENGLISH);
            
            int month = day.getMonthValue();
            String condition;
            int rainChance;
            int humidity;
            int tempMax;
            int tempMin;
            String advice;

            if (month == 6 || month == 7 || month == 8 || month == 9) {
                int rand = i % 4;
                if (rand == 0) {
                    condition = "Heavy Rain";
                    rainChance = 85 + (i % 10);
                    humidity = 92;
                    tempMax = 28;
                    tempMin = 22;
                    advice = "STOP molding. Cover green bricks immediately. High flood risk.";
                } else if (rand == 1) {
                    condition = "Light Rain";
                    rainChance = 65;
                    humidity = 82;
                    tempMax = 30;
                    tempMin = 23;
                    advice = "Cover active drying beds. Monitor coal moisture levels.";
                } else if (rand == 2) {
                    condition = "Cloudy";
                    rainChance = 35;
                    humidity = 75;
                    tempMax = 31;
                    tempMin = 24;
                    advice = "Slow solar drying. Keep tarpaulins ready on site.";
                } else {
                    condition = "Mostly Sunny";
                    rainChance = 10;
                    humidity = 60;
                    tempMax = 34;
                    tempMin = 25;
                    advice = "Excellent weather. Push maximum green brick output.";
                }
            } else {
                int rand = i % 5;
                if (rand == 0) {
                    condition = "Partly Cloudy";
                    rainChance = 5;
                    humidity = 38;
                    tempMax = 36;
                    tempMin = 21;
                    advice = "Standard operations. Clay drying rate is normal.";
                } else if (rand == 1) {
                    condition = "Sunny";
                    rainChance = 0;
                    humidity = 28;
                    tempMax = 39;
                    tempMin = 23;
                    advice = "Maximum solar drying speed. Expand molding capacity.";
                } else {
                    condition = "Mostly Sunny";
                    rainChance = 0;
                    humidity = 32;
                    tempMax = 37;
                    tempMin = 22;
                    advice = "Optimal kiln firing conditions. Accelerate loading.";
                }
            }

            list.add(new WeatherDay(dateStr, dayOfWeek, tempMax, tempMin, condition, rainChance, humidity, advice));
        }
        return list;
    }

    public static class WeatherDay {
        private final String date;
        private final String dayOfWeek;
        private final int tempMax;
        private final int tempMin;
        private final String condition;
        private final int rainChance;
        private final int humidity;
        private final String advice;

        public WeatherDay(String date, String dayOfWeek, int tempMax, int tempMin, String condition, int rainChance, int humidity, String advice) {
            this.date = date;
            this.dayOfWeek = dayOfWeek;
            this.tempMax = tempMax;
            this.tempMin = tempMin;
            this.condition = condition;
            this.rainChance = rainChance;
            this.humidity = humidity;
            this.advice = advice;
        }

        public String getDate() { return date; }
        public String getDayOfWeek() { return dayOfWeek; }
        public int getTempMax() { return tempMax; }
        public int getTempMin() { return tempMin; }
        public String getCondition() { return condition; }
        public int getRainChance() { return rainChance; }
        public int getHumidity() { return humidity; }
        public String getAdvice() { return advice; }
    }

    // 6. SYSTEM SETTINGS
    @GetMapping("/settings")
    public String showSettings(Model model) {
        model.addAttribute("settings", systemSettingService.getSettingsMap());
        return "admin/settings";
    }

    @PostMapping("/settings/save")
    public String saveSettings(@RequestParam Map<String, String> params, RedirectAttributes redirect) {
        try {
            for (Map.Entry<String, String> entry : params.entrySet()) {
                if (!entry.getKey().startsWith("_") && !entry.getKey().equals("id")) { // ignore spring csrf / helper parameters
                    systemSettingService.updateSetting(entry.getKey(), entry.getValue());
                }
            }
            redirect.addFlashAttribute("successMessage", "System settings updated successfully!");
        } catch (Exception e) {
            redirect.addFlashAttribute("errorMessage", "Failed to update settings: " + e.getMessage());
        }
        return "redirect:/admin/settings";
    }
}
