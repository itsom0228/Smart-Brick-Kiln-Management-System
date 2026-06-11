package com.dipaksarpane.kiln.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "gallery_images")
public class GalleryImage {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String title;

    @Column(length = 16777215, nullable = false)
    private String base64Data;

    @Column(nullable = false)
    private LocalDateTime uploadDate;

    // Constructors
    public GalleryImage() {}

    public GalleryImage(String title, String base64Data, LocalDateTime uploadDate) {
        this.title = title;
        this.base64Data = base64Data;
        this.uploadDate = uploadDate;
    }

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getBase64Data() { return base64Data; }
    public void setBase64Data(String base64Data) { this.base64Data = base64Data; }

    public LocalDateTime getUploadDate() { return uploadDate; }
    public void setUploadDate(LocalDateTime uploadDate) { this.uploadDate = uploadDate; }
}
