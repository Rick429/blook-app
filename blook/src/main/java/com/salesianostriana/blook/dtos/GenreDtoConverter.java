package com.salesianostriana.blook.dtos;

import com.salesianostriana.blook.models.Genre;
import org.springframework.stereotype.Component;

@Component
public class GenreDtoConverter {

    public Genre createGenreDtoToGenre(CreateGenreDto c) {
        return Genre.builder()
                .name(c.getName())
                .description(c.getDescription())
                .build();
    }

    public CreateGenreDto genreToCreateGenreDto(Genre g) {
        return CreateGenreDto.builder()
                .name(g.getName())
                .description(g.getDescription())
                .build();
    }

}
