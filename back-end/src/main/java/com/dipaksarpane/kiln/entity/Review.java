package com.dipaksarpane.kiln.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "reviews")
public class Review {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String fullName;

    @Column(nullable = false)
    private Integer rating; // 1 to 5 star rating

    @Column(nullable = false, length = 1000)
    private String reviewText;

    @Column(nullable = false)
    private Boolean approved = false; // Admin moderation required

    private LocalDateTime createdDate;

    // Constructors
    public Review() {}

    public Review(String fullName, Integer rating, String reviewText, Boolean approved, LocalDateTime createdDate) {
        this.fullName = fullName;
        this.rating = rating;
        this.reviewText = reviewText;
        this.approved = approved;
        this.createdDate = createdDate;
    }

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public Integer getRating() { return rating; }
    public void setRating(Integer rating) { this.rating = rating; }

    public String getReviewText() { return reviewText; }
    public void setReviewText(String reviewText) { this.reviewText = reviewText; }

    public Boolean getApproved() { return approved; }
    public void setApproved(Boolean approved) { this.approved = approved; }

    public LocalDateTime getCreatedDate() { return createdDate; }
    public void setCreatedDate(LocalDateTime createdDate) { this.createdDate = createdDate; }
}
