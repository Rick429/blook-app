package com.salesianostriana.blook.repositories;

import com.salesianostriana.blook.models.Genre;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.UUID;

public interface GenreRepository extends JpaRepository<Genre, UUID> {
}
