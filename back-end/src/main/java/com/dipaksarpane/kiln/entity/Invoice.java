package com.dipaksarpane.kiln.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "invoices")
public class Invoice {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true)
    private String invoiceNumber; // Generated uniquely (e.g. DSBI-INV-12345)

    @OneToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "order_id", nullable = false)
    private Order order;

    private String gstNumber; // Admin can specify or use business GST

    @Column(length = 1000)
    private String billingAddress;

    private LocalDateTime invoiceDate;

    // Constructors
    public Invoice() {}

    public Invoice(String invoiceNumber, Order order, String gstNumber, String billingAddress, LocalDateTime invoiceDate) {
        this.invoiceNumber = invoiceNumber;
        this.order = order;
        this.gstNumber = gstNumber;
        this.billingAddress = billingAddress;
        this.invoiceDate = invoiceDate;
    }

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getInvoiceNumber() { return invoiceNumber; }
    public void setInvoiceNumber(String invoiceNumber) { this.invoiceNumber = invoiceNumber; }

    public Order getOrder() { return order; }
    public void setOrder(Order order) { this.order = order; }

    public String getGstNumber() { return gstNumber; }
    public void setGstNumber(String gstNumber) { this.gstNumber = gstNumber; }

    public String getBillingAddress() { return billingAddress; }
    public void setBillingAddress(String billingAddress) { this.billingAddress = billingAddress; }

    public LocalDateTime getInvoiceDate() { return invoiceDate; }
    public void setInvoiceDate(LocalDateTime invoiceDate) { this.invoiceDate = invoiceDate; }
}
