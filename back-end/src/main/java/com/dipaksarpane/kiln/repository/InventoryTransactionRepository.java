package com.dipaksarpane.kiln.repository;

import com.dipaksarpane.kiln.entity.InventoryTransaction;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import java.time.LocalDateTime;
import java.util.List;

public interface InventoryTransactionRepository extends JpaRepository<InventoryTransaction, Long> {
    List<InventoryTransaction> findAllByOrderByTransactionDateDesc();
    List<InventoryTransaction> findByProductIdOrderByTransactionDateDesc(Long productId);

    @Query("SELECT it FROM InventoryTransaction it WHERE it.transactionDate BETWEEN :start AND :end ORDER BY it.transactionDate DESC")
    List<InventoryTransaction> findTransactionsBetweenDates(@Param("start") LocalDateTime start, @Param("end") LocalDateTime end);
}
