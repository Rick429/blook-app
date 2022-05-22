package com.salesianostriana.blook.services;

import com.salesianostriana.blook.dtos.*;
import com.salesianostriana.blook.enums.Estado;
import com.salesianostriana.blook.enums.TypeReport;
import com.salesianostriana.blook.enums.UserRole;
import com.salesianostriana.blook.errors.exceptions.ForbiddenException;
import com.salesianostriana.blook.errors.exceptions.ListEntityNotFoundException;
import com.salesianostriana.blook.errors.exceptions.OneEntityNotFound;
import com.salesianostriana.blook.models.Comment;
import com.salesianostriana.blook.models.Genre;
import com.salesianostriana.blook.models.Report;
import com.salesianostriana.blook.models.UserEntity;
import com.salesianostriana.blook.repositories.BookRepository;
import com.salesianostriana.blook.repositories.GenreRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;

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

    public Page<GetGenreDto> findAllGenres (Pageable pageable) {
        Page<Genre> lista = genreRepository.findAll(pageable);

        if(lista.isEmpty()) {
            throw new ListEntityNotFoundException(Genre.class);
        } else {
            return lista.map(genreDtoConverter::genreToGetGenreDto);
        }
    }

    public Page<GetGenreDto> buscarGenero(UserEntity user, BuscarGeneroDto b, Pageable pageable){
        if(user.getRole().equals(UserRole.ADMIN)){
            Page<Genre> lista = buscar(Optional.ofNullable(b.getName()),
                    Optional.ofNullable(b.getDescription()), pageable);
            if(lista.isEmpty()){
                throw new ListEntityNotFoundException(Genre.class);
            } else {
                return lista.map(genreDtoConverter::genreToGetGenreDto);
            }
        }else{
            throw new ForbiddenException("No tiene permisos para realizar esta acción");
        }
    }

    private Page<Genre> buscar(Optional<String> name, Optional<String> description, Pageable pageable) {
        Specification<Genre> specName = (root, query, criteriaBuilder) -> {
            if (name.isPresent()) {
                return criteriaBuilder.like(criteriaBuilder.lower(root.get("name")), "%" + name.get().toLowerCase() + "%");
            } else {
                return criteriaBuilder.isTrue(criteriaBuilder.literal(true));
            }
        };

        Specification<Genre> specDescription = (root, query, criteriaBuilder) -> {
            if (description.isPresent()) {
                return criteriaBuilder.like(criteriaBuilder.lower(root.get("description")), "%" + description.get().toLowerCase() + "%");
            } else {
                return criteriaBuilder.isTrue(criteriaBuilder.literal(true));
            }
        };

        Specification<Genre> todas =
                specName
                        .or(specDescription);

        return this.genreRepository.findAll(todas, pageable);
    }

}
