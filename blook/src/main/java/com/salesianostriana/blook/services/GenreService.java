package com.salesianostriana.blook.services;

import com.salesianostriana.blook.dtos.CreateGenreDto;
import com.salesianostriana.blook.dtos.GenreDtoConverter;
import com.salesianostriana.blook.enums.UserRole;
import com.salesianostriana.blook.errors.exceptions.ForbiddenException;
import com.salesianostriana.blook.errors.exceptions.OneEntityNotFound;
import com.salesianostriana.blook.models.Genre;
import com.salesianostriana.blook.models.UserEntity;
import com.salesianostriana.blook.repositories.BookRepository;
import com.salesianostriana.blook.repositories.GenreRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import java.util.Optional;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class GenreService {

    private final GenreRepository genreRepository;
    private final GenreDtoConverter genreDtoConverter;

    public Genre save(CreateGenreDto createGenreDto, UserEntity user){

        if(user.getRole().equals(UserRole.ADMIN)){
            return genreRepository.save(genreDtoConverter.createGenreDtoToGenre(createGenreDto));
        } else {
            throw new ForbiddenException("No tiene perminos para realizar esta acción");
        }
    }

    public Genre findById (UUID id) {
        return genreRepository.findById(id)
                .orElseThrow(() -> new OneEntityNotFound(id.toString(), Genre.class));
    }

    public Genre editGenre(CreateGenreDto c, UserEntity user, UUID id) {

        Optional<Genre> g1 = genreRepository.findById(id);

        if(g1.isEmpty()){
            throw new OneEntityNotFound(id.toString(), Genre.class);
        } else {
            if(user.getRole().equals(UserRole.ADMIN)){
               g1.get().setName(c.getName());
               g1.get().setDescription(c.getDescription());
                return genreRepository.save(g1.get());
            } else {
                throw new ForbiddenException("No tiene permisos para realizar esta acción");
            }
        }
    }

    public void deleteGenre (UUID id) {
        Optional<Genre> c = genreRepository.findById(id);

        if(c.isEmpty()) {
            throw new OneEntityNotFound(id.toString(), Genre.class);
        } else {
            genreRepository.deleteById(id);
        }
    }

}
