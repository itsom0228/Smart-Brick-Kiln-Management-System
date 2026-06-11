package com.dipaksarpane.kiln.entity;

import jakarta.persistence.*;
import java.math.BigDecimal;

@Entity
@Table(name = "products")
public class Product {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String name;

    @Column(nullable = false, unique = true)
    private String code;

    @Column(length = 1000)
    private String description;

    private String dimensions; // e.g. "9 x 4 x 3 inches"
    private String weight;     // e.g. "3.0 kg"
    private String strength;   // e.g. "7.5 N/mm2"

    @Column(nullable = false)
    private BigDecimal price;  // Unit price in INR

    @Column(nullable = false)
    private Integer availableStock;

    @Column(nullable = false)
    private Integer lowStockThreshold;

    @Lob
    @Column(columnDefinition = "LONGTEXT")
    private String imageUrl;

    // Constructors
    public Product() {}

    public Product(String name, String code, String description, String dimensions, String weight, String strength, BigDecimal price, Integer availableStock, Integer lowStockThreshold, String imageUrl) {
        this.name = name;
        this.code = code;
        this.description = description;
        this.dimensions = dimensions;
        this.weight = weight;
        this.strength = strength;
        this.price = price;
        this.availableStock = availableStock;
        this.lowStockThreshold = lowStockThreshold;
        this.imageUrl = imageUrl;
    }

    // Helper to check stock status
    public String getStockStatus() {
        if (availableStock <= 0) {
            return "OUT_OF_STOCK";
        } else if (availableStock <= lowStockThreshold) {
            return "LOW_STOCK";
        } else {
            return "IN_STOCK";
        }
    }

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getCode() { return code; }
    public void setCode(String code) { this.code = code; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getDimensions() { return dimensions; }
    public void setDimensions(String dimensions) { this.dimensions = dimensions; }

    public String getWeight() { return weight; }
    public void setWeight(String weight) { this.weight = weight; }

    public String getStrength() { return strength; }
    public void setStrength(String strength) { this.strength = strength; }

    public BigDecimal getPrice() { return price; }
    public void setPrice(BigDecimal price) { this.price = price; }

    public Integer getAvailableStock() { return availableStock; }
    public void setAvailableStock(Integer availableStock) { this.availableStock = availableStock; }

    public Integer getLowStockThreshold() { return lowStockThreshold; }
    public void setLowStockThreshold(Integer lowStockThreshold) { this.lowStockThreshold = lowStockThreshold; }

    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }
}
