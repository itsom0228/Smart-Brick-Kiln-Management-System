package com.dipaksarpane.kiln.service;

import com.dipaksarpane.kiln.entity.Order;
import com.dipaksarpane.kiln.entity.Product;
import com.dipaksarpane.kiln.entity.Quotation;
import com.dipaksarpane.kiln.repository.ProductRepository;
import com.dipaksarpane.kiln.repository.QuotationRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.Random;

@Service
@Transactional
public class QuotationService {

    private final QuotationRepository quotationRepository;
    private final ProductRepository productRepository;
    private final OrderService orderService;
    private final SystemSettingService systemSettingService;

    public QuotationService(QuotationRepository quotationRepository, 
                            ProductRepository productRepository, 
                            OrderService orderService,
                            SystemSettingService systemSettingService) {
        this.quotationRepository = quotationRepository;
        this.productRepository = productRepository;
        this.orderService = orderService;
        this.systemSettingService = systemSettingService;
    }

    public List<Quotation> getAllQuotations() {
        return quotationRepository.findAllByOrderByRequestDateDesc();
    }

    public Optional<Quotation> getQuotationById(Long id) {
        return quotationRepository.findById(id);
    }

    public Quotation requestQuotation(Quotation quotation) {
        Product product = productRepository.findById(quotation.getProduct().getId())
                .orElseThrow(() -> new IllegalArgumentException("Product not found"));

        quotation.setProduct(product);
        quotation.setProductTypeName(product.getName());
        quotation.setQuotationNumber(generateQuotationNumber());

        // Calculate initial estimates
        BigDecimal qty = BigDecimal.valueOf(quotation.getQuantity());
        BigDecimal productCost = product.getPrice().multiply(qty);
        
        // Fetch transport rate from settings
        BigDecimal transportRate = systemSettingService.getTransportRateStandard();
        if (product.getName().toLowerCase().contains("hollow")) {
            transportRate = systemSettingService.getTransportRateHollow();
        }
        BigDecimal transportCost = transportRate.multiply(qty);
        
        // Fetch GST from settings
        BigDecimal gstRate = systemSettingService.getGstRate();
        BigDecimal gstAmount = productCost.multiply(gstRate).setScale(2, RoundingMode.HALF_UP);
        BigDecimal totalCost = productCost.add(gstAmount).add(transportCost).setScale(2, RoundingMode.HALF_UP);

        quotation.setEstimatedProductCost(productCost);
        quotation.setEstimatedGstAmount(gstAmount);
        quotation.setEstimatedTransportCost(transportCost);
        quotation.setTotalEstimatedCost(totalCost);

        quotation.setStatus("PENDING");
        quotation.setRequestDate(LocalDateTime.now());

        return quotationRepository.save(quotation);
    }

    public Quotation updateQuotationStatus(Long id, String status) {
        Quotation quote = quotationRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Quotation not found ID: " + id));
        quote.setStatus(status);
        return quotationRepository.save(quote);
    }

    public Quotation updateQuotationEstimates(Long id, BigDecimal productCost, BigDecimal gstAmount, BigDecimal transportCost) {
        Quotation quote = quotationRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Quotation not found ID: " + id));

        quote.setEstimatedProductCost(productCost);
        quote.setEstimatedGstAmount(gstAmount);
        quote.setEstimatedTransportCost(transportCost);
        quote.setTotalEstimatedCost(productCost.add(gstAmount).add(transportCost));
        quote.setStatus("EDITED");

        return quotationRepository.save(quote);
    }

    public Order convertQuotationToOrder(Long quotationId, LocalDate targetDeliveryDate) {
        Quotation quote = quotationRepository.findById(quotationId)
                .orElseThrow(() -> new IllegalArgumentException("Quotation not found ID: " + quotationId));

        if (quote.getStatus().equals("CONVERTED_TO_ORDER")) {
            throw new IllegalStateException("Quotation is already converted to an order.");
        }

        quote.setStatus("CONVERTED_TO_ORDER");
        quotationRepository.save(quote);

        // Map quotation fields to Order
        Order order = new Order();
        order.setFullName(quote.getFullName());
        order.setMobileNumber(quote.getMobileNumber());
        order.setEmailAddress(quote.getEmail());
        order.setFullAddress(quote.getFullAddress());
        
        // Populate split address components with dummy values since quotation only has full address
        order.setVillage("N/A");
        order.setTaluka("N/A");
        order.setDistrict("N/A");
        order.setState("Maharashtra");
        order.setPincode("N/A");

        order.setProduct(quote.getProduct());
        order.setQuantity(quote.getQuantity());
        order.setDeliveryDate(targetDeliveryDate != null ? targetDeliveryDate : LocalDate.now().plusDays(3));
        order.setAdditionalNotes("Converted from Quotation: " + quote.getQuotationNumber());

        return orderService.placeOrder(order);
    }

    private String generateQuotationNumber() {
        Random rand = new Random();
        int num = 100000 + rand.nextInt(900000);
        return "DSBI-QT-" + num;
    }
}
