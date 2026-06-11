package com.dipaksarpane.kiln.entity;

import jakarta.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "quotations")
public class Quotation {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true)
    private String quotationNumber; // e.g. DSB-QT-123456

    @Column(nullable = false)
    private String fullName;

    @Column(nullable = false)
    private String mobileNumber;

    @Column(nullable = false)
    private String email;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_id")
    private Product product;

    private String productTypeName;

    @Column(nullable = false)
    private Integer quantity;

    @Column(nullable = false, length = 1000)
    private String fullAddress;

    // Financial estimations
    private BigDecimal estimatedProductCost;
    private BigDecimal estimatedGstAmount;
    private BigDecimal estimatedTransportCost;
    private BigDecimal totalEstimatedCost;

    @Column(nullable = false)
    private String status; // PENDING, APPROVED, EDITED, CONVERTED_TO_ORDER

    private LocalDateTime requestDate;

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getQuotationNumber() { return quotationNumber; }
    public void setQuotationNumber(String quotationNumber) { this.quotationNumber = quotationNumber; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getMobileNumber() { return mobileNumber; }
    public void setMobileNumber(String mobileNumber) { this.mobileNumber = mobileNumber; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public Product getProduct() { return product; }
    public void setProduct(Product product) { this.product = product; }

    public String getProductTypeName() { return productTypeName; }
    public void setProductTypeName(String productTypeName) { this.productTypeName = productTypeName; }

    public Integer getQuantity() { return quantity; }
    public void setQuantity(Integer quantity) { this.quantity = quantity; }

    public String getFullAddress() { return fullAddress; }
    public void setFullAddress(String fullAddress) { this.fullAddress = fullAddress; }

    public BigDecimal getEstimatedProductCost() { return estimatedProductCost; }
    public void setEstimatedProductCost(BigDecimal estimatedProductCost) { this.estimatedProductCost = estimatedProductCost; }

    public BigDecimal getEstimatedGstAmount() { return estimatedGstAmount; }
    public void setEstimatedGstAmount(BigDecimal estimatedGstAmount) { this.estimatedGstAmount = estimatedGstAmount; }

    public BigDecimal getEstimatedTransportCost() { return estimatedTransportCost; }
    public void setEstimatedTransportCost(BigDecimal estimatedTransportCost) { this.estimatedTransportCost = estimatedTransportCost; }

    public BigDecimal getTotalEstimatedCost() { return totalEstimatedCost; }
    public void setTotalEstimatedCost(BigDecimal totalEstimatedCost) { this.totalEstimatedCost = totalEstimatedCost; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public LocalDateTime getRequestDate() { return requestDate; }
    public void setRequestDate(LocalDateTime requestDate) { this.requestDate = requestDate; }
}
