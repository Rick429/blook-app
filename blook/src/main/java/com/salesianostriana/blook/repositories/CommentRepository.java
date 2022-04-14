package com.salesianostriana.blook.repositories;

import com.salesianostriana.blook.models.Comment;
import com.salesianostriana.blook.models.CommentPK;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CommentRepository extends JpaRepository<Comment, CommentPK> {

}
