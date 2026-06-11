package com.dipaksarpane.kiln.repository;

import com.dipaksarpane.kiln.entity.ContactMessage;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface ContactMessageRepository extends JpaRepository<ContactMessage, Long> {
    List<ContactMessage> findAllByOrderByCreatedDateDesc();
}
