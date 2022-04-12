package com.salesianostriana.blook.services;

import com.salesianostriana.blook.dtos.BookDtoConverter;
import com.salesianostriana.blook.dtos.CreateBookDto;
import com.salesianostriana.blook.dtos.GetBookDto;
import com.salesianostriana.blook.enums.UserRole;
import com.salesianostriana.blook.errors.exceptions.EntityNotFound;
import com.salesianostriana.blook.errors.exceptions.ListEntityNotFoundException;
import com.salesianostriana.blook.errors.exceptions.OneEntityNotFound;
import com.salesianostriana.blook.errors.exceptions.UnauthorizedException;
import com.salesianostriana.blook.models.Book;
import com.salesianostriana.blook.models.UserEntity;
import com.salesianostriana.blook.repositories.BookRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

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


    public Book save(CreateBookDto createBookDto, MultipartFile file, UserEntity user){
        String uri = storageService.store(file);
        uri = storageService.completeUri(uri);

        return bookRepository.save(bookDtoConverter.createBookDtoToBook(createBookDto, uri, user));
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
                    b1.get().getAutorLibroPublicado().getRole().equals(UserRole.ADMIN)){
                String uri = storageService.store(file);
                uri = storageService.completeUri(uri);
                b1.get().setName(c.getName());
                b1.get().setDescription(c.getDescription());
                b1.get().setCover(uri);
                return bookRepository.save(b1.get());
            } else {
                throw new UnauthorizedException("No tiene permisos para realizar esta acción");
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

    public List<GetBookDto> findAllBooks () {
        List<Book> lista = bookRepository.findAll();

        if(lista.isEmpty()) {
            throw new ListEntityNotFoundException(Book.class);
        } else {
            return lista.stream()
                    .map(bookDtoConverter::bookToGetBookDto)
                    .collect(Collectors.toList());
        }
    }

    public List<GetBookDto> findAllBooksUser (String nick) {
        Optional<UserEntity> u1 = userEntityService.findFirstByNick(nick);

        if(u1.isEmpty()) {
            throw new EntityNotFound("No se pudo encontrar el usuario con nick: "+ nick );
        } else {
            List<Book> lista = bookRepository.findByAutorLibroPublicado(u1.get());

            if(lista.isEmpty()) {
                throw new ListEntityNotFoundException(Book.class);
            } else {
                return lista.stream()
                        .map(bookDtoConverter::bookToGetBookDto)
                        .collect(Collectors.toList());
            }
        }

    }


}
