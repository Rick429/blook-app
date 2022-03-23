package com.salesianostriana.blook.repositories;

import com.salesianostriana.blook.models.Book;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.UUID;

public interface BookRepository extends JpaRepository<Book, UUID> {

}
