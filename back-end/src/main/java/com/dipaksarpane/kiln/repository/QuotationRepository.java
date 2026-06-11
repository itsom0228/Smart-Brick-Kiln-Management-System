package com.dipaksarpane.kiln.repository;

import com.dipaksarpane.kiln.entity.Quotation;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

public interface QuotationRepository extends JpaRepository<Quotation, Long> {
    Optional<Quotation> findByQuotationNumber(String quotationNumber);
    List<Quotation> findAllByOrderByRequestDateDesc();
    
    @Query("SELECT q FROM Quotation q WHERE q.requestDate BETWEEN :start AND :end ORDER BY q.requestDate DESC")
    List<Quotation> findQuotationsBetweenDates(@Param("start") LocalDateTime start, @Param("end") LocalDateTime end);
}
