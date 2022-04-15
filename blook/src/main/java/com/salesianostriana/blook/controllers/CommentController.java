package com.salesianostriana.blook.controllers;

import com.salesianostriana.blook.dtos.*;
import com.salesianostriana.blook.models.UserEntity;
import com.salesianostriana.blook.services.CommentService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.UUID;

@RestController
@RequiredArgsConstructor
@RequestMapping("/comment")
public class CommentController {

    private final CommentService commentService;
    private final CommentDtoConverter commentDtoConverter;

    @PostMapping("/{id}")
    public ResponseEntity<GetCommentDto> createComment(@Valid @RequestPart("comment") CreateCommentDto c,
                                                       @AuthenticationPrincipal UserEntity user,
                                                       @PathVariable UUID id) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(commentDtoConverter.commentToGetCommentDto(commentService.save(c,user, id)));
    }

    @GetMapping("/{id}")
    public GetCommentDto findCommentById(@PathVariable UUID id, @AuthenticationPrincipal UserEntity user) {
        return commentDtoConverter.commentToGetCommentDto(commentService.findById(id, user.getId()));
    }

    @PutMapping("/{id}")
    public GetCommentDto editComment(@Valid @RequestPart("comment") CreateCommentDto c,
                                     @AuthenticationPrincipal UserEntity user,
                                     @PathVariable UUID id) {
        return commentDtoConverter.commentToGetCommentDto(commentService.editComment(c, user, id));
    }


    @DeleteMapping("/{id}")
    public ResponseEntity<?> delete(@PathVariable UUID id, @AuthenticationPrincipal UserEntity user){
        commentService.deleteComment(id, user.getId());
        return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
    }

}
