package com.salesianostriana.blook.controllers;

import com.salesianostriana.blook.dtos.*;
import com.salesianostriana.blook.models.Book;
import com.salesianostriana.blook.models.Genre;
import com.salesianostriana.blook.models.Report;
import com.salesianostriana.blook.models.UserEntity;
import com.salesianostriana.blook.services.GenreService;
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
import java.util.UUID;

@RestController
@RequiredArgsConstructor
@RequestMapping("/blook/genre")
public class GenreController {

    private final GenreService genreService;
    private final GenreDtoConverter genreDtoConverter;
    private final PaginationLinksUtils paginationLinksUtils;

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
    public ResponseEntity<Page<GetGenreDto>> findAllGenres (@PageableDefault(size = 10, page = 0) Pageable pageable,
                                            @AuthenticationPrincipal UserEntity user,
                                            HttpServletRequest request) {
        Page<GetGenreDto> lista = genreService.findAllGenres(pageable);
        UriComponentsBuilder uriBuilder = UriComponentsBuilder.fromHttpUrl(request.getRequestURL().toString());
        return ResponseEntity.ok().header("link", paginationLinksUtils.createLinkHeader(lista, uriBuilder)).body(lista);

    }

    @Operation(summary = "Buscar géneros")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Se devuelve una lista con los géneros encontrados",
                    content = {@Content(mediaType = "aplication/json",
                            schema = @Schema(implementation = Genre.class))}),
            @ApiResponse(responseCode = "400",
                    description = "Error en los datos",
                    content = @Content),
            @ApiResponse(responseCode = "404",
                    description = "La lista esta vacia",
                    content = @Content),
    })
    @GetMapping("/find/")
    public ResponseEntity<Page<GetGenreDto>> findReports(@AuthenticationPrincipal UserEntity user,
                                                          @RequestPart("search") BuscarGeneroDto b,
                                                          @PageableDefault(size = 10, page = 0) Pageable pageable,
                                                          HttpServletRequest request) {

        Page<GetGenreDto> lista = genreService.buscarGenero(user,b,pageable);
        UriComponentsBuilder uriBuilder = UriComponentsBuilder.fromHttpUrl(request.getRequestURL().toString());
        return ResponseEntity.ok().header("link", paginationLinksUtils.createLinkHeader(lista, uriBuilder)).body(lista);
    }

}
