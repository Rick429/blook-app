package com.salesianostriana.blook.repositories;

import com.salesianostriana.blook.models.Comment;
import com.salesianostriana.blook.models.Genre;
import com.salesianostriana.blook.models.Report;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.UUID;

public interface GenreRepository extends JpaRepository<Genre, UUID> {

    Page<Genre> findAll(Specification<Genre> todas, Pageable pageable);
}
