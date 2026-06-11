package com.dipaksarpane.kiln.controller;

import com.dipaksarpane.kiln.entity.ContactMessage;
import com.dipaksarpane.kiln.entity.Review;
import com.dipaksarpane.kiln.repository.*;
import com.dipaksarpane.kiln.service.InventoryService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/admin")
public class AdminController {

    private final OrderRepository orderRepository;
    private final ProductRepository productRepository;
    private final QuotationRepository quotationRepository;
    private final ReviewRepository reviewRepository;
    private final ContactMessageRepository contactMessageRepository;
    private final InventoryService inventoryService;

    public AdminController(OrderRepository orderRepository, 
                           ProductRepository productRepository, 
                           QuotationRepository quotationRepository, 
                           ReviewRepository reviewRepository, 
                           ContactMessageRepository contactMessageRepository, 
                           InventoryService inventoryService) {
        this.orderRepository = orderRepository;
        this.productRepository = productRepository;
        this.quotationRepository = quotationRepository;
        this.reviewRepository = reviewRepository;
        this.contactMessageRepository = contactMessageRepository;
        this.inventoryService = inventoryService;
    }

    @GetMapping("/login")
    public String login() {
        return "admin/login";
    }

    @GetMapping("/dashboard")
    public String dashboard(Model model) {
        // Stats Cards
        long totalOrders = orderRepository.count();
        long pendingOrders = orderRepository.countByCurrentStatus("PENDING");
        long deliveredOrders = orderRepository.countByCurrentStatus("DELIVERED");
        
        BigDecimal totalRevenue = orderRepository.calculateTotalRevenue();
        if (totalRevenue == null) {
            totalRevenue = BigDecimal.ZERO;
        }
        
        long totalProducts = productRepository.count();
        long totalQuotations = quotationRepository.count();
        long totalReviews = reviewRepository.count();
        long totalEnquiries = contactMessageRepository.count();

        model.addAttribute("totalOrders", totalOrders);
        model.addAttribute("pendingOrders", pendingOrders);
        model.addAttribute("deliveredOrders", deliveredOrders);
        model.addAttribute("totalRevenue", totalRevenue);
        model.addAttribute("totalProducts", totalProducts);
        model.addAttribute("totalQuotations", totalQuotations);
        model.addAttribute("totalReviews", totalReviews);
        model.addAttribute("totalEnquiries", totalEnquiries);

        // Recent lists
        model.addAttribute("recentOrders", orderRepository.findAllByOrderByOrderDateDesc().stream().limit(5).toList());
        model.addAttribute("lowStockAlerts", inventoryService.getLowStockAlerts());
        model.addAttribute("recentEnquiries", contactMessageRepository.findAllByOrderByCreatedDateDesc().stream().limit(5).toList());

        // Dynamic Chart Data Injection
        // We will seed mock values matching actual database sizes for demonstration
        model.addAttribute("chartSales", List.of(12, 19, 3, 5, 2, 3, 10, 15, 8, 12, 14, 20)); // Months Jan-Dec
        model.addAttribute("chartRevenue", List.of(7500, 12000, 2000, 3500, 1500, 2100, 7000, 10500, 5600, 8400, 9800, 14000));
        
        return "admin/dashboard";
    }

    // REVIEW MODERATION
    @GetMapping("/reviews")
    public String viewReviews(Model model) {
        model.addAttribute("reviews", reviewRepository.findAllByOrderByCreatedDateDesc());
        return "admin/reviews";
    }

    @PostMapping("/reviews/approve/{id}")
    public String approveReview(@PathVariable Long id, RedirectAttributes redirect) {
        Optional<Review> reviewOpt = reviewRepository.findById(id);
        if (reviewOpt.isPresent()) {
            Review r = reviewOpt.get();
            r.setApproved(true);
            reviewRepository.save(r);
            redirect.addFlashAttribute("successMessage", "Review approved successfully!");
        }
        return "redirect:/admin/reviews";
    }

    @PostMapping("/reviews/delete/{id}")
    public String deleteReview(@PathVariable Long id, RedirectAttributes redirect) {
        reviewRepository.deleteById(id);
        redirect.addFlashAttribute("successMessage", "Review deleted successfully!");
        return "redirect:/admin/reviews";
    }

    // CONTACT MESSAGE / ENQUIRIES MODERATION
    @GetMapping("/enquiries")
    public String viewEnquiries(Model model) {
        model.addAttribute("enquiries", contactMessageRepository.findAllByOrderByCreatedDateDesc());
        return "admin/enquiries";
    }

    @PostMapping("/enquiries/reply/{id}")
    public String replyEnquiry(@PathVariable Long id, RedirectAttributes redirect) {
        Optional<ContactMessage> msgOpt = contactMessageRepository.findById(id);
        if (msgOpt.isPresent()) {
            ContactMessage m = msgOpt.get();
            m.setReplied(true);
            contactMessageRepository.save(m);
            redirect.addFlashAttribute("successMessage", "Marked enquiry as responded!");
        }
        return "redirect:/admin/enquiries";
    }
}
