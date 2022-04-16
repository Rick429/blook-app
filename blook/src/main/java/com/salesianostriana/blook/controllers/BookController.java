package com.salesianostriana.blook.controllers;

import com.salesianostriana.blook.dtos.BookDtoConverter;
import com.salesianostriana.blook.dtos.CreateBookDto;
import com.salesianostriana.blook.dtos.GetBookDto;
import com.salesianostriana.blook.enums.UserRole;
import com.salesianostriana.blook.models.Book;
import com.salesianostriana.blook.models.UserEntity;
import com.salesianostriana.blook.services.BookService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.util.UriComponentsBuilder;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.List;
import java.util.UUID;

@RestController
@RequiredArgsConstructor
@RequestMapping("/book")
public class BookController {

    private final BookService bookService;
    private final BookDtoConverter bookDtoConverter;

    @Operation(summary = "Crear un libro")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201",
                    description = "Se crea el libro correctamente",
                    content = {@Content(mediaType = "aplication/json",
                            schema = @Schema(implementation = Book.class))}),
            @ApiResponse(responseCode = "400",
                    description = "Error en los datos",
                    content = @Content),
    })
    @PostMapping("/")
    public ResponseEntity<GetBookDto> createBook(@Valid @RequestPart("book")CreateBookDto c,
                                                 @RequestPart("file")MultipartFile file,
                                                 @AuthenticationPrincipal UserEntity user) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(bookDtoConverter.bookToGetBookDto(bookService.save(c, file, user)));
    }

    @Operation(summary = "Obtener un libro")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Se encuentra el libro con el id dado",
                    content = {@Content(mediaType = "aplication/json",
                            schema = @Schema(implementation = Book.class))}),
            @ApiResponse(responseCode = "404",
                    description = "No se encontró ningún libro",
                    content = @Content),
    })
    @GetMapping("/{id}")
    public GetBookDto findBookById(@PathVariable UUID id) {
        return bookDtoConverter.bookToGetBookDto(bookService.findById(id));
    }

    @Operation(summary = "Editar un libro")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Se edita el libro correctamente",
                    content = {@Content(mediaType = "aplication/json",
                            schema = @Schema(implementation = Book.class))}),
            @ApiResponse(responseCode = "400",
                    description = "Error en los datos",
                    content = @Content),
            @ApiResponse(responseCode = "404",
                    description = "No se encontró el libro",
                    content = @Content),
    })
    @PutMapping("/{id}")
    public GetBookDto editBook(@Valid @RequestPart("book")CreateBookDto c,
                                               @RequestPart("file") MultipartFile file,
                                               @AuthenticationPrincipal UserEntity user,
                                               @PathVariable UUID id) {
        return bookDtoConverter.bookToGetBookDto(bookService.editBook(c, user, file, id));
    }

    @Operation(summary = "Eliminar un libro")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "204",
                    description = "Se elimina el libro correctamente",
                    content = {@Content(mediaType = "aplication/json",
                            schema = @Schema(implementation = Book.class))}),
            @ApiResponse(responseCode = "404",
                    description = "No se encuentró el libro",
                    content = @Content),
    })
    @DeleteMapping("/{id}")
    public ResponseEntity<?> delete(@PathVariable UUID id){
        bookService.deleteBook(id);
        return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
    }

    @Operation(summary = "Listar todos los libros")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Se devuelve una lista con todos los libros",
                    content = {@Content(mediaType = "aplication/json",
                            schema = @Schema(implementation = Book.class))}),
            @ApiResponse(responseCode = "404",
                    description = "La lista esta vacia",
                    content = @Content),
    })
    @GetMapping("/all")
    public List<GetBookDto> findAllBooks (@AuthenticationPrincipal UserEntity user) {
        return bookService.findAllBooks();
    }

    @Operation(summary = "Listar todos los libros de un usuario")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Se devuelve una lista con todos los libros",
                    content = {@Content(mediaType = "aplication/json",
                            schema = @Schema(implementation = Book.class))}),
            @ApiResponse(responseCode = "404",
                    description = "La lista esta vacia",
                    content = @Content),
    })
    @GetMapping("/all/user/{nick}")
    public List<GetBookDto> findAllBooksUser (@PathVariable String nick) {
        return bookService.findAllBooksUser(nick);
    }



}
