package com.dipaksarpane.kiln.controller;

import com.dipaksarpane.kiln.entity.ContactMessage;
import com.dipaksarpane.kiln.entity.Review;
import com.dipaksarpane.kiln.entity.Product;
import com.dipaksarpane.kiln.repository.ContactMessageRepository;
import com.dipaksarpane.kiln.repository.ReviewRepository;
import com.dipaksarpane.kiln.service.ProductService;
import com.dipaksarpane.kiln.service.SystemSettingService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import java.time.LocalDateTime;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

@Controller
public class MainController {

    private final ProductService productService;
    private final ReviewRepository reviewRepository;
    private final ContactMessageRepository contactMessageRepository;
    private final com.dipaksarpane.kiln.repository.GalleryImageRepository galleryImageRepository;
    private final SystemSettingService systemSettingService;

    public MainController(ProductService productService, 
                          ReviewRepository reviewRepository, 
                          ContactMessageRepository contactMessageRepository,
                          com.dipaksarpane.kiln.repository.GalleryImageRepository galleryImageRepository,
                          SystemSettingService systemSettingService) {
        this.productService = productService;
        this.reviewRepository = reviewRepository;
        this.contactMessageRepository = contactMessageRepository;
        this.galleryImageRepository = galleryImageRepository;
        this.systemSettingService = systemSettingService;
    }

    @GetMapping({"/", "/index"})
    public String index(Model model) {
        // Load approved reviews
        List<Review> approvedReviews = reviewRepository.findByApprovedTrueOrderByCreatedDateDesc();
        model.addAttribute("reviews", approvedReviews);
        model.addAttribute("newReview", new Review());
        
        // Load products for calculator dropdown
        model.addAttribute("products", productService.getAllProducts());
        
        // Load settings for cost estimation
        model.addAttribute("settings", systemSettingService.getSettingsMap());
        return "index";
    }

    @GetMapping("/about")
    public String about() {
        return "about";
    }

    @GetMapping("/gallery")
    public String gallery(Model model) {
        model.addAttribute("dynamicImages", galleryImageRepository.findAllByOrderByUploadDateDesc());
        return "gallery";
    }

    @GetMapping("/products")
    public String products(@RequestParam(value = "search", required = false) String search,
                           @RequestParam(value = "filter", required = false) String filter,
                           @RequestParam(value = "sort", required = false) String sort,
                           Model model) {
        List<Product> products = productService.searchProducts(search);

        // Filter products
        if (filter != null && !filter.trim().isEmpty() && !filter.equalsIgnoreCase("all")) {
            products = products.stream()
                    .filter(p -> p.getName().toLowerCase().contains(filter.toLowerCase()))
                    .collect(Collectors.toList());
        }

        // Sort products
        if (sort != null) {
            if (sort.equalsIgnoreCase("price_asc")) {
                products.sort(Comparator.comparing(Product::getPrice));
            } else if (sort.equalsIgnoreCase("price_desc")) {
                products.sort((p1, p2) -> p2.getPrice().compareTo(p1.getPrice()));
            } else if (sort.equalsIgnoreCase("name_asc")) {
                products.sort(Comparator.comparing(Product::getName));
            }
        }

        model.addAttribute("products", products);
        model.addAttribute("search", search);
        model.addAttribute("filter", filter);
        model.addAttribute("sort", sort);
        return "products";
    }

    @GetMapping("/calculator")
    public String calculator(Model model) {
        model.addAttribute("products", productService.getAllProducts());
        model.addAttribute("settings", systemSettingService.getSettingsMap());
        return "calculator";
    }

    @GetMapping("/contact")
    public String contact(Model model) {
        model.addAttribute("contactMessage", new ContactMessage());
        return "contact";
    }

    @PostMapping("/enquiry/submit")
    public String submitEnquiry(@ModelAttribute ContactMessage msg, RedirectAttributes redirect) {
        msg.setCreatedDate(LocalDateTime.now());
        msg.setReplied(false);
        contactMessageRepository.save(msg);
        redirect.addFlashAttribute("successMessage", "contact.form.success");
        return "redirect:/contact";
    }

    @PostMapping("/review/submit")
    public String submitReview(@ModelAttribute Review review, RedirectAttributes redirect) {
        review.setCreatedDate(LocalDateTime.now());
        review.setApproved(false); // Moderation required
        reviewRepository.save(review);
        redirect.addFlashAttribute("successMessage", "review.success");
        return "redirect:/index";
    }
}
