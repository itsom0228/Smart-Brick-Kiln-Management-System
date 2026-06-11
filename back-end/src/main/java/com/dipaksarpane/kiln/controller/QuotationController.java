package com.dipaksarpane.kiln.controller;

import com.dipaksarpane.kiln.entity.Product;
import com.dipaksarpane.kiln.entity.Quotation;
import com.dipaksarpane.kiln.service.ProductService;
import com.dipaksarpane.kiln.service.QuotationService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import java.util.List;

@Controller
@RequestMapping("/quotation")
public class QuotationController {

    private final QuotationService quotationService;
    private final ProductService productService;

    public QuotationController(QuotationService quotationService, ProductService productService) {
        this.quotationService = quotationService;
        this.productService = productService;
    }

    @GetMapping("/request")
    public String requestForm(Model model, @RequestParam(value = "productId", required = false) Long productId) {
        List<Product> products = productService.getAllProducts();
        model.addAttribute("products", products);
        
        Quotation quotation = new Quotation();
        if (productId != null) {
            productService.getProductById(productId).ifPresent(quotation::setProduct);
        }
        model.addAttribute("quotation", quotation);
        return "quotation";
    }

    @PostMapping("/submit")
    public String submitQuotation(@ModelAttribute Quotation quotation, RedirectAttributes redirect) {
        try {
            Quotation saved = quotationService.requestQuotation(quotation);
            redirect.addFlashAttribute("successQuoteNo", saved.getQuotationNumber());
            return "redirect:/quotation/success";
        } catch (Exception e) {
            redirect.addFlashAttribute("errorMessage", "Failed to submit quote request: " + e.getMessage());
            return "redirect:/quotation/request";
        }
    }

    @GetMapping("/success")
    public String success() {
        return "quotation-success";
    }
}
