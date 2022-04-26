package com.salesianostriana.blook.repositories;

import com.salesianostriana.blook.models.Book;
import com.salesianostriana.blook.models.UserEntity;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import java.util.UUID;

public interface BookRepository extends JpaRepository<Book, UUID> {

    Page<Book> findByAutorLibroPublicado(UserEntity user, Pageable pageable);

    Page<Book> findByUserLibroFavorito(UserEntity user, Pageable pageable);

    @Query("SELECT b FROM Book b ORDER BY b.releaseDate DESC")
    Page<Book> findTop10OrderByReleaseDateDesc(Pageable pageable);

    Page<Book> findAllByOrderByNameAsc(Pageable pageable);

    Page<Book> findByNameIgnoreCaseContains(String name, Pageable pageable);
}
