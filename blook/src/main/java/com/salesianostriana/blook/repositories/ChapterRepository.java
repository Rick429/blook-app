package com.salesianostriana.blook.repositories;

import com.salesianostriana.blook.models.Book;
import com.salesianostriana.blook.models.Chapter;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.UUID;

public interface ChapterRepository extends JpaRepository<Chapter, UUID> {

    Page<Chapter> findByNameIgnoreCaseContains(String name, Pageable pageable);

}
