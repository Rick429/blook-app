package com.salesianostriana.blook.controllers;

import com.salesianostriana.blook.dtos.*;
import com.salesianostriana.blook.models.UserEntity;
import com.salesianostriana.blook.services.ChapterService;
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

    @PostMapping("/{id}")
    public ResponseEntity<GetChapterDto> createChapter(@Valid @RequestPart("chapter") CreateChapterDto c,
                                                       @RequestPart("file") MultipartFile file,
                                                       @AuthenticationPrincipal UserEntity user,
                                                       @PathVariable UUID id) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(chapterDtoConverter.chapterToGetChapterDto(chapterService.save(c, file,user, id)));
    }

    @GetMapping("/{id}")
    public GetChapterDto findChapterById(@PathVariable UUID id) {
        return chapterDtoConverter.chapterToGetChapterDto(chapterService.findById(id));
    }

    @PutMapping("/{id}")
    public GetChapterDto editChapter(@Valid @RequestPart("chapter")CreateChapterDto c,
                               @RequestPart("file") MultipartFile file,
                               @AuthenticationPrincipal UserEntity user,
                               @PathVariable UUID id) {
        return chapterDtoConverter.chapterToGetChapterDto(chapterService.editChapter(c, user, file, id));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> delete(@PathVariable UUID id){
        chapterService.deleteChapter(id);
        return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
    }

}
