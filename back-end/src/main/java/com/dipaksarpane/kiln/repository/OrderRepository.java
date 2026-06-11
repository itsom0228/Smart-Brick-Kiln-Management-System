package com.dipaksarpane.kiln.repository;

import com.dipaksarpane.kiln.entity.Order;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

public interface OrderRepository extends JpaRepository<Order, Long> {
    Optional<Order> findByOrderNumber(String orderNumber);

    @Query("SELECT o FROM Order o WHERE o.orderNumber = :orderNumber AND o.mobileNumber = :mobileNumber")
    Optional<Order> findForTracking(@Param("orderNumber") String orderNumber, @Param("mobileNumber") String mobileNumber);

    List<Order> findAllByOrderByOrderDateDesc();

    List<Order> findByCurrentStatus(String status);

    long countByCurrentStatus(String status);

    @Query("SELECT SUM(o.totalCost) FROM Order o WHERE o.currentStatus = 'DELIVERED'")
    BigDecimal calculateTotalRevenue();

    @Query("SELECT o FROM Order o WHERE o.orderDate BETWEEN :start AND :end ORDER BY o.orderDate DESC")
    List<Order> findOrdersBetweenDates(@Param("start") LocalDateTime start, @Param("end") LocalDateTime end);

    @Query("SELECT o FROM Order o WHERE " +
           "LOWER(o.fullName) LIKE LOWER(CONCAT('%', :query, '%')) OR " +
           "LOWER(o.orderNumber) LIKE LOWER(CONCAT('%', :query, '%')) OR " +
           "LOWER(o.mobileNumber) LIKE CONCAT('%', :query, '%')")
    List<Order> searchOrders(@Param("query") String query);
}
