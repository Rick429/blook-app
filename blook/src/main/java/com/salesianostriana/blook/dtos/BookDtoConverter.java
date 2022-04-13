package com.salesianostriana.blook.dtos;

import com.salesianostriana.blook.models.Book;
import com.salesianostriana.blook.models.UserEntity;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import java.util.stream.Collectors;

@Component
@RequiredArgsConstructor
public class BookDtoConverter {

    private final ChapterDtoConverter chapterDtoConverter;

    public Book createBookDtoToBook(CreateBookDto createBookDto, String uri) {
        return Book.builder()
                .name(createBookDto.getName())
                .description(createBookDto.getDescription())
                .cover(uri)
                .build();
    }

    public GetBookDto bookToGetBookDto(Book b) {
        return GetBookDto.builder()
                .id(b.getId())
                .name(b.getName())
                .description(b.getDescription())
                .cover(b.getCover())
                .relase_date(b.getRelase_date())
                .chapters(b.getChapters().stream().map(chapterDtoConverter::chapterToGetChapterDto).collect(Collectors.toList()))
                .build();
    }
}
