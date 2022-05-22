package com.salesianostriana.blook.services;

import com.salesianostriana.blook.dtos.ChapterDtoConverter;
import com.salesianostriana.blook.dtos.CreateChapterDto;
import com.salesianostriana.blook.dtos.GetBookDto;
import com.salesianostriana.blook.dtos.GetChapterDto;
import com.salesianostriana.blook.enums.UserRole;
import com.salesianostriana.blook.errors.exceptions.ForbiddenException;
import com.salesianostriana.blook.errors.exceptions.ListEntityNotFoundException;
import com.salesianostriana.blook.errors.exceptions.OneEntityNotFound;
import com.salesianostriana.blook.models.Book;
import com.salesianostriana.blook.models.Chapter;
import com.salesianostriana.blook.models.UserEntity;
import com.salesianostriana.blook.repositories.BookRepository;
import com.salesianostriana.blook.repositories.ChapterRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import java.util.Optional;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class ChapterService {

    private final ChapterRepository chapterRepository;
    private final StorageService storageService;
    private final ChapterDtoConverter chapterDtoConverter;
    private final BookRepository bookRepository;


    public Chapter save(CreateChapterDto createChapterDto, MultipartFile file, UserEntity user, UUID id){

        Optional<Book> b = bookRepository.findById(id);
        if(b.isEmpty()){
            throw new OneEntityNotFound(id.toString(), Book.class);
        } else {
            if(user.getId().equals(b.get().getAutorLibroPublicado().getId()) || user.getRole().equals(UserRole.ADMIN)){
                String uri = storageService.store(file);
                uri = storageService.completeUri(uri);
                Chapter c = chapterDtoConverter.createChapterDtoToChapter(createChapterDto, uri);
                c.addChapterToBook(b.get());
                bookRepository.save(b.get());
                return chapterRepository.save(c);
            } else {
                throw new ForbiddenException("No tiene perminos para realizar esta acción");
            }
        }
    }

    public Chapter findById (UUID id) {
        return chapterRepository.findById(id)
                .orElseThrow(() -> new OneEntityNotFound(id.toString(), Chapter.class));
    }

    public Chapter editChapter(CreateChapterDto c, UserEntity user, UUID id) {

        Optional<Chapter> c1 = chapterRepository.findById(id);

        if(c1.isEmpty()){
            throw new OneEntityNotFound(id.toString(), Chapter.class);
        } else {
            if(c1.get().getLibro().getAutorLibroPublicado().getId().equals(user.getId())||
                    user.getRole().equals(UserRole.ADMIN)){
                c1.get().setName(c.getName());
                return chapterRepository.save(c1.get());
            } else {
                throw new ForbiddenException("No tiene permisos para realizar esta acción");
            }
        }
    }

    public Chapter editChapterFile(UserEntity user, MultipartFile file, UUID id) {

        Optional<Chapter> c1 = chapterRepository.findById(id);

        if(c1.isEmpty()){
            throw new OneEntityNotFound(id.toString(), Chapter.class);
        } else {
            if(c1.get().getLibro().getAutorLibroPublicado().getId().equals(user.getId())||
                    user.getRole().equals(UserRole.ADMIN)){
                String uri = storageService.store(file);
                uri = storageService.completeUri(uri);
                if(!c1.get().getFile().isEmpty()) {
                    storageService.deleteFile(c1.get().getFile());
                }
                c1.get().setFile(uri);
                return chapterRepository.save(c1.get());
            } else {
                throw new ForbiddenException("No tiene permisos para realizar esta acción");
            }
        }
    }

    public void deleteChapter (UUID id) {
        Optional<Chapter> c = chapterRepository.findById(id);

        if(c.isEmpty()) {
            throw new OneEntityNotFound(id.toString(), Chapter.class);
        } else {
            c.get().removeChapterFromBook(c.get().getLibro());
            storageService.deleteFile(c.get().getFile());
            chapterRepository.deleteById(id);
        }
    }

    public Page<GetChapterDto> findAllChapters (Pageable pageable) {
        Page<Chapter> lista = chapterRepository.findAll(pageable);

        if(lista.isEmpty()) {
            throw new ListEntityNotFoundException(Chapter.class);
        } else {
            return lista.map(chapterDtoConverter::chapterToGetChapterDto);
        }
    }

    public Page<GetChapterDto> findByName (String name, Pageable pageable) {
        Page<Chapter> lista = chapterRepository.findByNameIgnoreCaseContains(name, pageable);

        if(lista.isEmpty()) {
            throw new ListEntityNotFoundException(Chapter.class);
        } else {
            return lista.map(chapterDtoConverter::chapterToGetChapterDto);

        }
    }

}
