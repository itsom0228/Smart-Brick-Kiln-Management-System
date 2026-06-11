package com.dipaksarpane.kiln.service;

import com.dipaksarpane.kiln.entity.InventoryTransaction;
import com.dipaksarpane.kiln.entity.Product;
import com.dipaksarpane.kiln.repository.InventoryTransactionRepository;
import com.dipaksarpane.kiln.repository.ProductRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Service
@Transactional
public class InventoryService {

    private final InventoryTransactionRepository transactionRepository;
    private final ProductRepository productRepository;

    public InventoryService(InventoryTransactionRepository transactionRepository, ProductRepository productRepository) {
        this.transactionRepository = transactionRepository;
        this.productRepository = productRepository;
    }

    public List<InventoryTransaction> getAllTransactions() {
        return transactionRepository.findAllByOrderByTransactionDateDesc();
    }

    public List<InventoryTransaction> getTransactionsByProduct(Long productId) {
        return transactionRepository.findByProductIdOrderByTransactionDateDesc(productId);
    }

    public void addStock(Long productId, Integer quantity, String remarks) {
        Product product = productRepository.findById(productId)
                .orElseThrow(() -> new IllegalArgumentException("Product not found ID: " + productId));

        product.setAvailableStock(product.getAvailableStock() + quantity);
        productRepository.save(product);

        InventoryTransaction tx = new InventoryTransaction(product, "ENTRY", quantity, LocalDateTime.now(), remarks);
        transactionRepository.save(tx);
    }

    public void exitStock(Long productId, Integer quantity, String remarks) {
        Product product = productRepository.findById(productId)
                .orElseThrow(() -> new IllegalArgumentException("Product not found ID: " + productId));

        if (product.getAvailableStock() < quantity) {
            throw new IllegalStateException("Insufficient stock to remove. Available: " 
                    + product.getAvailableStock() + ", Request: " + quantity);
        }

        product.setAvailableStock(product.getAvailableStock() - quantity);
        productRepository.save(product);

        InventoryTransaction tx = new InventoryTransaction(product, "EXIT", quantity, LocalDateTime.now(), remarks);
        transactionRepository.save(tx);
    }

    public void deductStockForOrder(Product product, Integer quantity, String remarks) {
        if (product.getAvailableStock() < quantity) {
            // Log warning but continue or adjust. Typically we deduct anyway and let it run to negative,
            // or block order. For brick kilns, let's allow it but warn, or strictly deduct:
            product.setAvailableStock(product.getAvailableStock() - quantity);
        } else {
            product.setAvailableStock(product.getAvailableStock() - quantity);
        }
        productRepository.save(product);

        InventoryTransaction tx = new InventoryTransaction(product, "DEDUCTION", quantity, LocalDateTime.now(), remarks);
        transactionRepository.save(tx);
    }

    public List<Product> getLowStockAlerts() {
        return productRepository.findAll().stream()
                .filter(p -> p.getAvailableStock() <= p.getLowStockThreshold())
                .collect(Collectors.toList());
    }
}
