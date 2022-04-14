package com.salesianostriana.blook.services;

import com.salesianostriana.blook.dtos.CommentDtoConverter;
import com.salesianostriana.blook.dtos.CreateCommentDto;
import com.salesianostriana.blook.errors.exceptions.OneEntityNotFound;
import com.salesianostriana.blook.models.Book;
import com.salesianostriana.blook.models.Comment;
import com.salesianostriana.blook.models.UserEntity;
import com.salesianostriana.blook.repositories.BookRepository;
import com.salesianostriana.blook.repositories.CommentRepository;
import com.salesianostriana.blook.repositories.UserEntityRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.Optional;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class CommentService {

    private final CommentRepository commentRepository;
    private final BookRepository bookRepository;
    private final UserEntityRepository userEntityRepository;
    private final CommentDtoConverter commentDtoConverter;

    public Comment save(CreateCommentDto c, UserEntity user, UUID id) {

        Optional<Book> b = bookRepository.findById(id);
        Optional<UserEntity> u = userEntityRepository.findById(user.getId());

        if(b.isEmpty()){
            throw new OneEntityNotFound(id.toString(), Book.class);
        } else {
            Comment comment = commentDtoConverter.createCommentDtoToComment(c);
            comment.addUserCommentToBook(u.get(),b.get());
            return commentRepository.save(comment);
        }
    }
}
