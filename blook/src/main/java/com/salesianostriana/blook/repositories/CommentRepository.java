package com.salesianostriana.blook.repositories;

import com.salesianostriana.blook.models.Book;
import com.salesianostriana.blook.models.Comment;
import com.salesianostriana.blook.models.CommentPK;
import com.salesianostriana.blook.models.UserEntity;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CommentRepository extends JpaRepository<Comment, CommentPK> {

    Page<Comment> findByLibroComentado(Book book, Pageable pageable);
}
