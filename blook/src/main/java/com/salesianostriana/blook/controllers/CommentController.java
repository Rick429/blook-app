package com.salesianostriana.blook.controllers;

import com.salesianostriana.blook.dtos.CommentDtoConverter;
import com.salesianostriana.blook.dtos.CreateChapterDto;
import com.salesianostriana.blook.dtos.CreateCommentDto;
import com.salesianostriana.blook.dtos.GetChapterDto;
import com.salesianostriana.blook.models.UserEntity;
import com.salesianostriana.blook.services.CommentService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.Valid;
import java.util.UUID;

@RestController
@RequiredArgsConstructor
@RequestMapping("/comment")
public class CommentController {

    private final CommentService commentService;
    private final CommentDtoConverter commentDtoConverter;

    @PostMapping("/{id}")
    public ResponseEntity<GetCommentDto> createComment(@Valid @RequestPart("chapter") CreateCommentDto c,
                                                       @AuthenticationPrincipal UserEntity user,
                                                       @PathVariable UUID id) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(commentDtoConverter.commentToGetCommentDto(commentService.save(c,user, id)));
    }
}
