package com.salesianostriana.blook.controllers;

import com.salesianostriana.blook.dtos.*;
import com.salesianostriana.blook.models.Book;
import com.salesianostriana.blook.models.Chapter;
import com.salesianostriana.blook.models.Comment;
import com.salesianostriana.blook.models.UserEntity;
import com.salesianostriana.blook.services.ChapterService;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.util.UriComponentsBuilder;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.List;
import java.util.UUID;

@RestController
@RequiredArgsConstructor
@RequestMapping("/blook/chapter")
public class ChapterController {

    private final ChapterService chapterService;
    private final ChapterDtoConverter chapterDtoConverter;
    private final PaginationLinksUtils paginationLinksUtils;

    @Operation(summary = "Crear un capitulo")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201",
                    description = "Se crea el capitulo correctamente",
                    content = {@Content(mediaType = "aplication/json",
                            schema = @Schema(implementation = Chapter.class))}),
            @ApiResponse(responseCode = "400",
                    description = "Error en los datos",
                    content = @Content),
    })
    @PostMapping("/{id}")
    public ResponseEntity<GetChapterDto> createChapter(@Valid @RequestPart("chapter") CreateChapterDto c,
                                                       @RequestPart("file") MultipartFile file,
                                                       @AuthenticationPrincipal UserEntity user,
                                                       @PathVariable UUID id) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(chapterDtoConverter.chapterToGetChapterDto(chapterService.save(c, file,user, id)));
    }

    @Operation(summary = "Obtener un capitulo")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Se encuentra el capitulo con el id dado",
                    content = {@Content(mediaType = "aplication/json",
                            schema = @Schema(implementation = Chapter.class))}),
            @ApiResponse(responseCode = "404",
                    description = "No se encontró ningún capitulo",
                    content = @Content),
    })
    @GetMapping("/{id}")
    public GetChapterDto findChapterById(@PathVariable UUID id) {
        return chapterDtoConverter.chapterToGetChapterDto(chapterService.findById(id));
    }

    @Operation(summary = "Editar nombre de un capitulo")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Se edita el capitulo correctamente",
                    content = {@Content(mediaType = "aplication/json",
                            schema = @Schema(implementation = Chapter.class))}),
            @ApiResponse(responseCode = "400",
                    description = "Error en los datos",
                    content = @Content),
            @ApiResponse(responseCode = "404",
                    description = "No se encontró el capitulo",
                    content = @Content),
    })
    @PutMapping("/{id}")
    public GetChapterDto editChapter(@Valid @RequestPart("chapter")CreateChapterDto c,
                               @AuthenticationPrincipal UserEntity user,
                               @PathVariable UUID id) {
        return chapterDtoConverter.chapterToGetChapterDto(chapterService.editChapter(c, user, id));
    }

    @Operation(summary = "Editar archivo de un capitulo")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Se edita el capitulo correctamente",
                    content = {@Content(mediaType = "aplication/json",
                            schema = @Schema(implementation = Chapter.class))}),
            @ApiResponse(responseCode = "400",
                    description = "Error en los datos",
                    content = @Content),
            @ApiResponse(responseCode = "404",
                    description = "No se encontró el capitulo",
                    content = @Content),
    })
    @PutMapping("/file/{id}")
    public GetChapterDto editChapterFile(@RequestPart("file") MultipartFile file,
                                     @AuthenticationPrincipal UserEntity user,
                                     @PathVariable UUID id) {
        return chapterDtoConverter.chapterToGetChapterDto(chapterService.editChapterFile(user, file, id));
    }

    @Operation(summary = "Eliminar un capitulo")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "204",
                    description = "Se elimina el capitulo correctamente",
                    content = {@Content(mediaType = "aplication/json",
                            schema = @Schema(implementation = Chapter.class))}),
            @ApiResponse(responseCode = "404",
                    description = "No se encuentró el capitulo",
                    content = @Content),
    })
    @DeleteMapping("/{id}")
    public ResponseEntity<?> delete(@PathVariable UUID id){
        chapterService.deleteChapter(id);
        return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
    }

    @Operation(summary = "Listar todos los capitulos")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Se devuelve una lista con todos los capitulos",
                    content = {@Content(mediaType = "aplication/json",
                            schema = @Schema(implementation = Chapter.class))}),
            @ApiResponse(responseCode = "404",
                    description = "La lista esta vacia",
                    content = @Content),
    })
    @GetMapping("/all")
    public ResponseEntity<Page<GetChapterDto>> findAllChapters (@PageableDefault(size = 10, page = 0) Pageable pageable,
                                                          @AuthenticationPrincipal UserEntity user,
                                                          HttpServletRequest request) {
        Page<GetChapterDto> lista = chapterService.findAllChapters(pageable);
        UriComponentsBuilder uriBuilder = UriComponentsBuilder.fromHttpUrl(request.getRequestURL().toString());
        return ResponseEntity.ok().header("link", paginationLinksUtils.createLinkHeader(lista, uriBuilder)).body(lista);
    }

    @Operation(summary = "Buscar capitulos")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Devuelve una lista con los capitulos",
                    content = {@Content(mediaType = "aplication/json",
                            schema = @Schema(implementation = Chapter.class))}),
            @ApiResponse(responseCode = "404",
                    description = "La lista esta vacia",
                    content = @Content),
    })
    @GetMapping("/search/all")
    public ResponseEntity<Page<GetChapterDto>> findByName (@RequestPart("search") SearchDto searchDto,
                                                        @PageableDefault(size = 10, page = 0) Pageable pageable,
                                                        HttpServletRequest request) {
        Page<GetChapterDto> lista = chapterService.findByName(searchDto.getName(), pageable);
        UriComponentsBuilder uriBuilder = UriComponentsBuilder.fromHttpUrl(request.getRequestURL().toString());
        return ResponseEntity.ok().header("link", paginationLinksUtils.createLinkHeader(lista, uriBuilder)).body(lista);
    }

}
