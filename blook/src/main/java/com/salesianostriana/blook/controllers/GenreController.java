package com.salesianostriana.blook.controllers;

import com.salesianostriana.blook.dtos.*;
import com.salesianostriana.blook.models.Book;
import com.salesianostriana.blook.models.Genre;
import com.salesianostriana.blook.models.UserEntity;
import com.salesianostriana.blook.services.GenreService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
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

    @Operation(summary = "Crear un género")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201",
                    description = "Se crea el género correctamente",
                    content = {@Content(mediaType = "aplication/json",
                            schema = @Schema(implementation = Genre.class))}),
            @ApiResponse(responseCode = "400",
                    description = "Error en los datos",
                    content = @Content),
    })
    @PostMapping("/")
    public ResponseEntity<CreateGenreDto> createGenre(@Valid @RequestPart("genre") CreateGenreDto c,
                                                      @AuthenticationPrincipal UserEntity user) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(genreDtoConverter.genreToCreateGenreDto(genreService.save(c,user)));
    }

    @Operation(summary = "Obtener un género")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Se encuentra el género con el id dado",
                    content = {@Content(mediaType = "aplication/json",
                            schema = @Schema(implementation = Genre.class))}),
            @ApiResponse(responseCode = "404",
                    description = "No se encontró ningún género",
                    content = @Content),
    })
    @GetMapping("/{id}")
    public CreateGenreDto findGenreById(@PathVariable UUID id) {
        return genreDtoConverter.genreToCreateGenreDto(genreService.findById(id));
    }

    @Operation(summary = "Editar un género")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Se edita el género correctamente",
                    content = {@Content(mediaType = "aplication/json",
                            schema = @Schema(implementation = Genre.class))}),
            @ApiResponse(responseCode = "400",
                    description = "Error en los datos",
                    content = @Content),
            @ApiResponse(responseCode = "404",
                    description = "No se encontró el género",
                    content = @Content),
    })
    @PutMapping("/{id}")
    public CreateGenreDto editGenre(@Valid @RequestPart("genre") CreateGenreDto c,
                                     @AuthenticationPrincipal UserEntity user,
                                     @PathVariable UUID id) {
        return genreDtoConverter.genreToCreateGenreDto(genreService.editGenre(c, user, id));
    }

    @Operation(summary = "Eliminar un género")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "204",
                    description = "Se elimina el género correctamente",
                    content = {@Content(mediaType = "aplication/json",
                            schema = @Schema(implementation = Genre.class))}),
            @ApiResponse(responseCode = "404",
                    description = "No se encuentró el género",
                    content = @Content),
    })
    @DeleteMapping("/{id}")
    public ResponseEntity<?> delete(@PathVariable UUID id){
        genreService.deleteGenre(id);
        return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
    }

    @Operation(summary = "Listar todos los géneros")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Se devuelve una lista con todos los géneros",
                    content = {@Content(mediaType = "aplication/json",
                            schema = @Schema(implementation = Genre.class))}),
            @ApiResponse(responseCode = "404",
                    description = "La lista esta vacia",
                    content = @Content),
    })
    @GetMapping("/all")
    public List<GetGenreDto> findAllGenres (@AuthenticationPrincipal UserEntity user) {
        return genreService.findAllGenres();
    }

}
