package com.salesianostriana.blook.controllers;

import com.salesianostriana.blook.dtos.*;
import com.salesianostriana.blook.errors.exceptions.EntityNotFound;
import com.salesianostriana.blook.errors.exceptions.ListEntityNotFoundException;
import com.salesianostriana.blook.models.Book;
import com.salesianostriana.blook.models.Chapter;
import com.salesianostriana.blook.models.Comment;
import com.salesianostriana.blook.models.UserEntity;
import com.salesianostriana.blook.repositories.BookRepository;
import com.salesianostriana.blook.services.CommentService;
import com.salesianostriana.blook.utils.PaginationLinksUtils;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.util.UriComponentsBuilder;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.Optional;
import java.util.UUID;

@RestController
@RequiredArgsConstructor
@RequestMapping("/blook/comment")
public class CommentController {

    private final CommentService commentService;
    private final CommentDtoConverter commentDtoConverter;
    private final PaginationLinksUtils paginationLinksUtils;

    @Operation(summary = "Crear un comentario")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201",
                    description = "Se crea el comentario correctamente",
                    content = {@Content(mediaType = "aplication/json",
                            schema = @Schema(implementation = Comment.class))}),
            @ApiResponse(responseCode = "400",
                    description = "Error en los datos",
                    content = @Content),
    })
    @PostMapping("/{id}")
    public ResponseEntity<GetCommentDto> createComment(@Valid @RequestPart("comment") CreateCommentDto c,
                                                       @AuthenticationPrincipal UserEntity user,
                                                       @PathVariable UUID id) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(commentDtoConverter.commentToGetCommentDto(commentService.save(c,user, id)));
    }

    @Operation(summary = "Obtener un comentario")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Se encuentra el comentario con el id dado",
                    content = {@Content(mediaType = "aplication/json",
                            schema = @Schema(implementation = Comment.class))}),
            @ApiResponse(responseCode = "404",
                    description = "No se encontró ningún comentario",
                    content = @Content),
    })
    @GetMapping("/{id}")
    public GetCommentDto findCommentById(@PathVariable UUID id, @AuthenticationPrincipal UserEntity user) {
        return commentDtoConverter.commentToGetCommentDto(commentService.findById(id, user.getId()));
    }

    @Operation(summary = "Editar un comentario")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Se edita el comentario correctamente",
                    content = {@Content(mediaType = "aplication/json",
                            schema = @Schema(implementation = Comment.class))}),
            @ApiResponse(responseCode = "400",
                    description = "Error en los datos",
                    content = @Content),
            @ApiResponse(responseCode = "404",
                    description = "No se encontró el comentario",
                    content = @Content),
    })
    @PutMapping("/{id}")
    public GetCommentDto editComment(@Valid @RequestPart("comment") CreateCommentDto c,
                                     @AuthenticationPrincipal UserEntity user,
                                     @PathVariable UUID id) {
        return commentDtoConverter.commentToGetCommentDto(commentService.editComment(c, user, id));
    }

    @Operation(summary = "Eliminar un comentario")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "204",
                    description = "Se elimina el comentario correctamente",
                    content = {@Content(mediaType = "aplication/json",
                            schema = @Schema(implementation = Comment.class))}),
            @ApiResponse(responseCode = "404",
                    description = "No se encuentró el comentario",
                    content = @Content),
    })
    @DeleteMapping("/{id}")
    public ResponseEntity<?> delete(@PathVariable UUID id, @AuthenticationPrincipal UserEntity user){
        commentService.deleteComment(id, user.getId());
        return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
    }

    @Operation(summary = "Listar todos los comentarios de un libro")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Se devuelve una lista con todos los comentarios del libro",
                    content = {@Content(mediaType = "aplication/json",
                            schema = @Schema(implementation = Comment.class))}),
            @ApiResponse(responseCode = "404",
                    description = "La lista esta vacia",
                    content = @Content),
    })
    @GetMapping("/all/{id}")
    public ResponseEntity<Page<GetCommentDto>> findAllCommentsByBookId (@PageableDefault(size = 10, page = 0) Pageable pageable,
                                                                        HttpServletRequest request,
                                                                        @PathVariable UUID id) {
        Page<GetCommentDto> lista = commentService.findAllCommentsByBookId(id, pageable);
        UriComponentsBuilder uriBuilder = UriComponentsBuilder.fromHttpUrl(request.getRequestURL().toString());
        return ResponseEntity.ok().header("link", paginationLinksUtils.createLinkHeader(lista, uriBuilder)).body(lista);
    }

    @Operation(summary = "Listar todos los comentarios")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Se devuelve una lista con todos los comentarios",
                    content = {@Content(mediaType = "aplication/json",
                            schema = @Schema(implementation = Comment.class))}),
            @ApiResponse(responseCode = "404",
                    description = "La lista esta vacia",
                    content = @Content),
    })
    @GetMapping("/all")
    public ResponseEntity<Page<GetCommentDto>> findAllComments (@PageableDefault(size = 10, page = 0) Pageable pageable,
                                                                HttpServletRequest request,
                                                                @AuthenticationPrincipal UserEntity user) {
        Page<GetCommentDto> lista = commentService.findAllComments(user, pageable);
        UriComponentsBuilder uriBuilder = UriComponentsBuilder.fromHttpUrl(request.getRequestURL().toString());
        return ResponseEntity.ok().header("link", paginationLinksUtils.createLinkHeader(lista, uriBuilder)).body(lista);
    }

    @Operation(summary = "Buscar comentario")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Devuelve una lista con los comentarios",
                    content = {@Content(mediaType = "aplication/json",
                            schema = @Schema(implementation = Comment.class))}),
            @ApiResponse(responseCode = "404",
                    description = "La lista esta vacia",
                    content = @Content),
    })
    @PostMapping("/search/")
    public ResponseEntity<Page<GetCommentDto>> findByComment (@RequestPart("search") SearchDto searchDto,
                                                        @PageableDefault(size = 10, page = 0) Pageable pageable,
                                                        HttpServletRequest request) {
        Page<GetCommentDto> lista = commentService.findByComment(searchDto.getComment(), pageable);
        UriComponentsBuilder uriBuilder = UriComponentsBuilder.fromHttpUrl(request.getRequestURL().toString());
        return ResponseEntity.ok().header("link", paginationLinksUtils.createLinkHeader(lista, uriBuilder)).body(lista);
    }

}
