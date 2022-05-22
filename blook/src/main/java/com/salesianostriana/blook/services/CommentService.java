package com.salesianostriana.blook.services;

import com.salesianostriana.blook.dtos.*;
import com.salesianostriana.blook.enums.UserRole;
import com.salesianostriana.blook.errors.exceptions.EntityNotFound;
import com.salesianostriana.blook.errors.exceptions.ForbiddenException;
import com.salesianostriana.blook.errors.exceptions.ListEntityNotFoundException;
import com.salesianostriana.blook.errors.exceptions.OneEntityNotFound;
import com.salesianostriana.blook.models.*;
import com.salesianostriana.blook.repositories.BookRepository;
import com.salesianostriana.blook.repositories.CommentRepository;
import com.salesianostriana.blook.repositories.UserEntityRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

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

    public Comment findById (UUID book_id, UUID user_id) {

        CommentPK id = new CommentPK(user_id, book_id);
        return commentRepository.findById(id)
                .orElseThrow(() -> new OneEntityNotFound(id.toString(), Comment.class));
    }

    public Comment editComment(CreateCommentDto c, UserEntity user, UUID book_id) {

        CommentPK id = new CommentPK(user.getId(), book_id);
        Optional<Comment> c1 = commentRepository.findById(id);

        if(c1.isEmpty()){
            throw new OneEntityNotFound(id.toString(), Comment.class);
        } else {
            if(c1.get().getComentador().getId().equals(user.getId()) ||
                    user.getRole().equals(UserRole.ADMIN)){
                c1.get().setComment(c.getComment());
                return commentRepository.save(c1.get());
            } else {
                throw new ForbiddenException("No tiene permisos para realizar esta acción");
            }
        }
    }

    public void deleteComment (UUID book_id, UUID user_id) {

        CommentPK id = new CommentPK(user_id, book_id);
        Optional<Comment> c = commentRepository.findById(id);

        if(c.isEmpty()) {
            throw new OneEntityNotFound(id.toString(), Comment.class);
        } else {
            Optional<Book> b = bookRepository.findById(book_id);
            Optional<UserEntity> u = userEntityRepository.findById(user_id);

            c.get().removeUserCommentToBook(u.get(), b.get());
            commentRepository.deleteById(id);
        }

    }

    public Page<GetCommentDto> findAllCommentsByBookId (UUID bookId, Pageable pageable) {
        Optional<Book> b1 = bookRepository.findById(bookId);

        if(b1.isEmpty()) {
            throw new EntityNotFound("No se pudo encontrar el libro con id: "+ bookId );
        } else {
            Page<Comment> lista = commentRepository.findByLibroComentado(b1.get(), pageable);

            if(lista.isEmpty()) {
                throw new ListEntityNotFoundException(Comment.class);
            } else {
                return lista.map(commentDtoConverter::commentToGetCommentDto);
            }
        }
    }

    public Page<GetCommentDto> findAllComments (UserEntity user, Pageable pageable) {

        if(!user.getRole().equals(UserRole.ADMIN)) {
            throw new ForbiddenException("No tiene permisos para realizar esta acción");
        } else {
            Page<Comment> lista = commentRepository.findAll(pageable);

            if(lista.isEmpty()) {
                throw new ListEntityNotFoundException(Comment.class);
            } else {
                return lista.map(commentDtoConverter::commentToGetCommentDto);
            }
        }
    }

    public Page<GetCommentDto> findByComment (String comment, Pageable pageable) {
        Page<Comment> lista = commentRepository.findByCommentIgnoreCaseContains(comment, pageable);

        if(lista.isEmpty()) {
            throw new ListEntityNotFoundException(Comment.class);
        } else {
            return lista.map(commentDtoConverter::commentToGetCommentDto);

        }
    }
}
