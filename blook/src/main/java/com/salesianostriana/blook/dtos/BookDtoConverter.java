package com.salesianostriana.blook.dtos;

import com.salesianostriana.blook.models.Book;
import com.salesianostriana.blook.models.UserEntity;
import org.springframework.stereotype.Component;

@Component
public class BookDtoConverter {

    public Book createBookDtoToBook(CreateBookDto createBookDto, String uri, UserEntity user) {
        return Book.builder()
                .name(createBookDto.getName())
                .description(createBookDto.getDescription())
                .cover(uri)
                .autorLibroPublicado(user)
                .build();
    }

    public GetBookDto bookToGetBookDto(Book b) {
        return GetBookDto.builder()
                .id(b.getId())
                .name(b.getName())
                .description(b.getDescription())
                .cover(b.getCover())
                .relase_date(b.getRelase_date())
                .build();
    }
}
