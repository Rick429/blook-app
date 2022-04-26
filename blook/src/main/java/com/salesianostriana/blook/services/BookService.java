package com.salesianostriana.blook.services;

import com.salesianostriana.blook.dtos.BookDtoConverter;
import com.salesianostriana.blook.dtos.CreateBookDto;
import com.salesianostriana.blook.dtos.GetBookDto;
import com.salesianostriana.blook.enums.UserRole;
import com.salesianostriana.blook.errors.exceptions.EntityNotFound;
import com.salesianostriana.blook.errors.exceptions.ForbiddenException;
import com.salesianostriana.blook.errors.exceptions.ListEntityNotFoundException;
import com.salesianostriana.blook.errors.exceptions.OneEntityNotFound;
import com.salesianostriana.blook.models.Book;
import com.salesianostriana.blook.models.Genre;
import com.salesianostriana.blook.models.UserEntity;
import com.salesianostriana.blook.repositories.BookRepository;
import com.salesianostriana.blook.repositories.GenreRepository;
import com.salesianostriana.blook.repositories.UserEntityRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class BookService {

    private final BookRepository bookRepository;
    private final StorageService storageService;
    private final BookDtoConverter bookDtoConverter;
    private final UserEntityService userEntityService;
    private final UserEntityRepository userEntityRepository;
    private final GenreRepository genreRepository;


    public Book save(CreateBookDto createBookDto, MultipartFile file, UserEntity user){
        Optional<UserEntity> u = userEntityRepository.findById(user.getId());
        if(u.isEmpty()) {
            throw new OneEntityNotFound(user.getId().toString(), UserEntity.class);
        } else {
            String uri = storageService.store(file);
            uri = storageService.completeUri(uri);
            Book b = bookDtoConverter.createBookDtoToBook(createBookDto, uri);
            List<Genre> list= new ArrayList<>();
            for (Genre g:createBookDto.getGeneros()) {
                list.add(genreRepository.findById(g.getId()).get());
            }
            b.getGenres().addAll(list);
            b.addBookToUser(u.get());
            return bookRepository.save(b);
        }
    }

    public Book findById (UUID id) {
        return bookRepository.findById(id)
                .orElseThrow(() -> new OneEntityNotFound(id.toString(), Book.class));
    }

    public Book editBook(CreateBookDto c,UserEntity user,MultipartFile file, UUID id) {

        Optional<Book> b1 = bookRepository.findById(id);

        if(b1.isEmpty()){
            throw new OneEntityNotFound(id.toString(), Book.class);
        } else {
            if(b1.get().getAutorLibroPublicado().getId().equals(user.getId())||
                    user.getRole().equals(UserRole.ADMIN)){
                String uri = storageService.store(file);
                uri = storageService.completeUri(uri);
                b1.get().setName(c.getName());
                b1.get().setDescription(c.getDescription());
                if(!b1.get().getCover().isEmpty()) {
                    storageService.deleteFile(b1.get().getCover());
                }
                b1.get().setCover(uri);
                return bookRepository.save(b1.get());
            } else {
                throw new ForbiddenException("No tiene permisos para realizar esta acción");
            }
        }
    }

    public void deleteBook (UUID id) {
        Optional<Book> b = bookRepository.findById(id);

        if(b.isEmpty()) {
            throw new OneEntityNotFound(id.toString(), Book.class);
        } else {
            b.get().removeBookFromUser(b.get().getAutorLibroPublicado());
            storageService.deleteFile(b.get().getCover());
            bookRepository.deleteById(id);
        }
    }

    public Page<GetBookDto> findAllBooks (Pageable pageable) {
        Page<Book> lista = bookRepository.findAll(pageable);

        if(lista.isEmpty()) {
            throw new ListEntityNotFoundException(Book.class);
        } else {
            return lista.map(bookDtoConverter::bookToGetBookDto);
        }
    }

    public Page<GetBookDto> findAllBooksUser (String nick, Pageable pageable) {
        Optional<UserEntity> u1 = userEntityService.findFirstByNick(nick);

        if(u1.isEmpty()) {
            throw new EntityNotFound("No se pudo encontrar el usuario con nick: "+ nick );
        } else {
            Page<Book> lista = bookRepository.findByAutorLibroPublicado(u1.get(), pageable);

            if(lista.isEmpty()) {
                throw new ListEntityNotFoundException(Book.class);
            } else {
                return lista.map(bookDtoConverter::bookToGetBookDto);
            }
        }
    }

    public Book addFavoriteBook(UUID idbook, UserEntity user){
        Optional<UserEntity> u = userEntityRepository.findById(user.getId());
        if(u.isEmpty()) {
            throw new OneEntityNotFound(user.getId().toString(), UserEntity.class);
        } else {
            Optional<Book> b = bookRepository.findById(idbook);
            if(b.isEmpty()) {
                throw new OneEntityNotFound(idbook.toString(), Book.class);
            } else {

                b.get().addBookFavoriteToUser(u.get());
                return bookRepository.save(b.get());
            }
        }
    }

    public Page<GetBookDto> findAllFavoriteBooks (String nick, Pageable pageable) {
        Optional<UserEntity> u1 = userEntityService.findFirstByNick(nick);

        if(u1.isEmpty()) {
            throw new EntityNotFound("No se pudo encontrar el usuario con nick: "+ nick );
        } else {
            Page<Book> lista = bookRepository.findByUserLibroFavorito(u1.get(), pageable);

            if(lista.isEmpty()) {
                throw new ListEntityNotFoundException(Book.class);
            } else {
                return lista.map(bookDtoConverter::bookToGetBookDto);
            }
        }
    }

    public Page<GetBookDto> findAllNewBooks (Pageable pageable) {
        Page<Book> lista = bookRepository.findTop10OrderByReleaseDateDesc(pageable);

        if(lista.isEmpty()) {
            throw new ListEntityNotFoundException(Book.class);
        } else {
            return lista.map(bookDtoConverter::bookToGetBookDto);

        }
    }

    public Page<GetBookDto> findAllBooksOrderByName (Pageable pageable) {
        Page<Book> lista = bookRepository.findAllByOrderByNameAsc(pageable);

        if(lista.isEmpty()) {
            throw new ListEntityNotFoundException(Book.class);
        } else {
            return lista.map(bookDtoConverter::bookToGetBookDto);

        }
    }

    public Page<GetBookDto> findByName (String name, Pageable pageable) {
        Page<Book> lista = bookRepository.findByNameIgnoreCaseContains(name, pageable);

        if(lista.isEmpty()) {
            throw new ListEntityNotFoundException(Book.class);
        } else {
            return lista.map(bookDtoConverter::bookToGetBookDto);

        }
    }

}
