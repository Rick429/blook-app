package com.salesianostriana.blook.dtos;

import com.salesianostriana.blook.models.Comment;
import org.springframework.stereotype.Component;

@Component
public class CommentDtoConverter {

    public Comment createCommentDtoToComment(CreateCommentDto c) {
        return Comment.builder()
                .comment(c.getComment())
                .build();
    }

    public GetCommentDto commentToGetCommentDto(Comment c) {
        return GetCommentDto.builder()
                .comment(c.getComment())
                .user_id(c.getComentador().getId())
                .book_id(c.getLibroComentado().getId())
                .avatar(c.getComentador().getAvatar())
                .nick(c.getComentador().getNick())
                .created_date(c.getCreatedDate())
                .build();
    }
}
