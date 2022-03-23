package com.salesianostriana.blook.repositories;

import com.salesianostriana.blook.models.Chapter;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.UUID;

public interface ChapterRepository extends JpaRepository<Chapter, UUID> {

}
