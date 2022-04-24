package com.salesianostriana.blook.controllers;

import com.salesianostriana.blook.dtos.*;
import com.salesianostriana.blook.models.Chapter;
import com.salesianostriana.blook.models.UserEntity;
import com.salesianostriana.blook.services.ChapterService;
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
import java.util.UUID;

@RestController
@RequiredArgsConstructor
@RequestMapping("/chapter")
public class ChapterController {

    private final ChapterService chapterService;
    private final ChapterDtoConverter chapterDtoConverter;

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

    @Operation(summary = "Editar un capitulo")
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
                               @RequestPart("file") MultipartFile file,
                               @AuthenticationPrincipal UserEntity user,
                               @PathVariable UUID id) {
        return chapterDtoConverter.chapterToGetChapterDto(chapterService.editChapter(c, user, file, id));
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

}
