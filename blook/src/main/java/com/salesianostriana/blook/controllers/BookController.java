package com.salesianostriana.blook.controllers;

import com.salesianostriana.blook.dtos.BookDtoConverter;
import com.salesianostriana.blook.dtos.CreateBookDto;
import com.salesianostriana.blook.dtos.GetBookDto;
import com.salesianostriana.blook.enums.UserRole;
import com.salesianostriana.blook.models.UserEntity;
import com.salesianostriana.blook.services.BookService;
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


    @PostMapping("/")
    public ResponseEntity<GetBookDto> createBook(@Valid @RequestPart("book")CreateBookDto c,
                                                 @RequestPart("file")MultipartFile file,
                                                 @AuthenticationPrincipal UserEntity user) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(bookDtoConverter.bookToGetBookDto(bookService.save(c, file, user)));
    }

    @GetMapping("/{id}")
    public ResponseEntity<GetBookDto> findBookById(@PathVariable UUID id) {
        return ResponseEntity.status(HttpStatus.OK)
                .body(bookDtoConverter.bookToGetBookDto(bookService.findById(id)));
    }

    @PutMapping("/{id}")
    public GetBookDto editBook(@Valid @RequestPart("book")CreateBookDto c,
                                               @RequestPart("file") MultipartFile file,
                                               @AuthenticationPrincipal UserEntity user,
                                               @PathVariable UUID id) {
        return bookDtoConverter.bookToGetBookDto(bookService.editBook(c, user, file, id));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> delete(@PathVariable UUID id){
        bookService.deleteBook(id);
        return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
    }

    @GetMapping("/all")
    public List<GetBookDto> findAllBooks (@AuthenticationPrincipal UserEntity user) {
        return bookService.findAllBooks();
    }

    @GetMapping("/all/user/{nick}")
    public List<GetBookDto> findAllBooksUser (@PathVariable String nick) {
        return bookService.findAllBooksUser(nick);
    }



}
