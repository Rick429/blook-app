package com.salesianostriana.blook.dtos;

import com.salesianostriana.blook.models.Chapter;
import org.springframework.stereotype.Component;

@Component
public class ChapterDtoConverter {

    public Chapter createChapterDtoToChapter(CreateChapterDto c, String uri) {
        return Chapter.builder()
                .name(c.getName())
                .file(uri)
                .build();
    }

    public GetChapterDto chapterToGetChapterDto(Chapter c) {
        return GetChapterDto.builder()
                .id(c.getId())
                .name(c.getName())
                .file(c.getFile())
                .build();
    }
}
