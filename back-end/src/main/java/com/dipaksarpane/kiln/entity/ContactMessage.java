package com.dipaksarpane.kiln.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "contact_messages")
public class ContactMessage {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String fullName;

    @Column(nullable = false)
    private String mobileNumber;

    private String email;

    @Column(nullable = false, length = 2000)
    private String messageText;

    private LocalDateTime createdDate;
    private Boolean replied = false;

    // Constructors
    public ContactMessage() {}

    public ContactMessage(String fullName, String mobileNumber, String email, String messageText, LocalDateTime createdDate) {
        this.fullName = fullName;
        this.mobileNumber = mobileNumber;
        this.email = email;
        this.messageText = messageText;
        this.createdDate = createdDate;
    }

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getMobileNumber() { return mobileNumber; }
    public void setMobileNumber(String mobileNumber) { this.mobileNumber = mobileNumber; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getMessageText() { return messageText; }
    public void setMessageText(String messageText) { this.messageText = messageText; }

    public LocalDateTime getCreatedDate() { return createdDate; }
    public void setCreatedDate(LocalDateTime createdDate) { this.createdDate = createdDate; }

    public Boolean getReplied() { return replied; }
    public void setReplied(Boolean replied) { this.replied = replied; }

    public String getFormattedDate() {
        if (createdDate == null) return "";
        return createdDate.format(java.time.format.DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));
    }
}
