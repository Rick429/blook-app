package com.salesianostriana.blook.repositories;

import com.salesianostriana.blook.models.Book;
import com.salesianostriana.blook.models.UserEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.UUID;

public interface BookRepository extends JpaRepository<Book, UUID> {

    List<Book> findByAutorLibroPublicado(UserEntity user);

}
