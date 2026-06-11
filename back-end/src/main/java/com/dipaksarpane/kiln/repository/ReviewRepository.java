package com.dipaksarpane.kiln.repository;

import com.dipaksarpane.kiln.entity.Review;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface ReviewRepository extends JpaRepository<Review, Long> {
    List<Review> findByApprovedTrueOrderByCreatedDateDesc();
    List<Review> findAllByOrderByCreatedDateDesc();
}
