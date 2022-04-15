package com.salesianostriana.blook.controllers;

import com.salesianostriana.blook.dtos.*;
import com.salesianostriana.blook.models.UserEntity;
import com.salesianostriana.blook.services.GenreService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.Valid;
import java.util.List;
import java.util.UUID;

@RestController
@RequiredArgsConstructor
@RequestMapping("/genre")
public class GenreController {

    private final GenreService genreService;
    private final GenreDtoConverter genreDtoConverter;

    @PostMapping("/")
    public ResponseEntity<CreateGenreDto> createGenre(@Valid @RequestPart("genre") CreateGenreDto c,
                                                      @AuthenticationPrincipal UserEntity user) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(genreDtoConverter.genreToCreateGenreDto(genreService.save(c,user)));
    }

    @GetMapping("/{id}")
    public CreateGenreDto findGenreById(@PathVariable UUID id) {
        return genreDtoConverter.genreToCreateGenreDto(genreService.findById(id));
    }

    @PutMapping("/{id}")
    public CreateGenreDto editGenre(@Valid @RequestPart("genre") CreateGenreDto c,
                                     @AuthenticationPrincipal UserEntity user,
                                     @PathVariable UUID id) {
        return genreDtoConverter.genreToCreateGenreDto(genreService.editGenre(c, user, id));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> delete(@PathVariable UUID id){
        genreService.deleteGenre(id);
        return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
    }

    @GetMapping("/all")
    public List<GetGenreDto> findAllGenres (@AuthenticationPrincipal UserEntity user) {
        return genreService.findAllGenres();
    }

}
