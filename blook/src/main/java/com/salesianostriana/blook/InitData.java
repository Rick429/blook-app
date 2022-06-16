package com.salesianostriana.blook;

import com.salesianostriana.blook.enums.UserRole;
import com.salesianostriana.blook.models.Book;
import com.salesianostriana.blook.models.Chapter;
import com.salesianostriana.blook.models.Genre;
import com.salesianostriana.blook.models.UserEntity;
import com.salesianostriana.blook.repositories.BookRepository;
import com.salesianostriana.blook.repositories.ChapterRepository;
import com.salesianostriana.blook.repositories.GenreRepository;
import com.salesianostriana.blook.repositories.UserEntityRepository;
import com.salesianostriana.blook.services.StorageService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;
import javax.annotation.PostConstruct;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.List;

@Component
@RequiredArgsConstructor
public class InitData {

    private final BookRepository bookRepository;
    private final StorageService storageService;
    private final UserEntityRepository userEntityRepository;
    private final ChapterRepository chapterRepository;
    private final PasswordEncoder passwordEncoder;
    private final GenreRepository genreRepository;

    @PostConstruct
    public void run() throws IOException {

        Genre g = Genre.builder()
                .name("Fantasía")
                .description("Es un género artístico en el que hay presencia de elementos que rompen con la realidad establecida.")
                .build();

        genreRepository.save(g);
        UserEntity u = UserEntity.builder()
                .name("admin")
                .avatar("")
                .lastname("admin")
                .email("admin@gmail.com")
                .password(passwordEncoder.encode("admin"))
                .nick("admin")
                .role(UserRole.ADMIN)
                .build();
        userEntityRepository.save(u);
        byte[] byteImg1 = Files.readAllBytes(Paths.get("libro1.png"));
        String filename =  storageService.store(byteImg1, "libro1.png", "png");
        byte[] bytePdf1 = Files.readAllBytes(Paths.get("libro1-1-18.pdf"));
        String filename1 =  storageService.store(bytePdf1, "libro1-1-18.pdf", "pdf");
        byte[] bytePdf2 = Files.readAllBytes(Paths.get("libro1-19-26.pdf"));
        String filename2 =  storageService.store(bytePdf2, "libro1-19-26.pdf", "pdf");
        String uri = "http://10.0.2.2:8080/download/" + filename;
        String uri1 = "http://10.0.2.2:8080/download/" + filename1;
        String uri2 = "http://10.0.2.2:8080/download/" + filename2;

        Book b1 = Book.builder()
                .autorLibroPublicado(u)
              .cover(uri)
              .name("Harry Potter y la piedra filosofal")
              .description("Harry Potter se ha quedado huérfano y vive en casa de sus abominables tíos y el insoportable primo Dudley. Harry se siente muy triste y solo, hasta que un buen día recibe una carta que cambiará su vida para siempre. En ella le comunican que ha sido aceptado como alumno en el Colegio Hogwarts de Magia. A partir de ese momento, la suerte de Harry da un vuelco espectacular. En esa escuela tan especial aprenderá encantamientos, trucos fabulosos y tácticas de defensa contra las malas artes. Se convertirá en el campeón escolar de Quidditch, especie de fútbol aéreo que se juega montado sobre escobas, y hará un puñado de buenos amigos... aunque también algunos temibles enemigos. Pero, sobre todo, conocerá los secretos que le permitirán cumplir su destino. Pues, aunque no lo parezca a primera vista, Harry no es un chico común y corriente: ¡es un verdadero mago!")
                .genres(List.of(g))
              .build();

        Chapter c1 = Chapter.builder()
                .name("El niño que sobrevivió")
                .file(uri1)
                .libro(b1)
                .build();
        Chapter c2 = Chapter.builder()
                .name("El vidrio que se desvaneció")
                .file(uri2)
                .libro(b1)
                .build();


        byte[] byteImg2 = Files.readAllBytes(Paths.get("libro2.png"));
        String filename3 =  storageService.store(byteImg2, "libro2.png", "png");
        byte[] bytePdf3 = Files.readAllBytes(Paths.get("libro2-1-13.pdf"));
        String filename4 =  storageService.store(bytePdf3, "libro2-1-13.pdf", "pdf");
        String uri3 = "http://10.0.2.2:8080/download/" + filename3;
        String uri4 = "http://10.0.2.2:8080/download/" + filename4;
        Book b2 = Book.builder()
                .autorLibroPublicado(u)
                .cover(uri3)
                .name("Harry Potter y la cámara secreta")
                .description("Tras derrotar una vez más a lord Voldemort, su siniestro enemigo en Harry Potter y la piedra filosofal, Harry espera impaciente en casa de sus insoportables tíos el inicio del segundo curso del Colegio Hogwarts de Magia. Sin embargo, la espera dura poco, pues un elfo aparece en su habitación y le advierte que una amenaza mortal se cierne sobre la escuela. Así pues, Harry no se lo piensa dos veces y, acompañado de Ron, su mejor amigo, se dirige a Hogwarts en un coche volador. Pero ¿puede un aprendiz de mago defender la escuela de los malvados que pretenden destruirla? Sin saber que alguien había abierto la Cámara de los Secretos, dejando escapar una serie de monstruos peligrosos, Harry y sus amigos Ron y Hermione tendrán que enfrentarse con arañas gigantes, serpientes encantadas, fantasmas enfurecidos y, sobre todo, con la mismísima reencarnación de su más temible adversario.")
                .genres(List.of(g))
                .build();

        Chapter c3 = Chapter.builder()
                .name("El peor cumpleaños")
                .file(uri4)
                .libro(b2)
                .build();

        byte[] byteImg3 = Files.readAllBytes(Paths.get("libro3.png"));
        String filename5 =  storageService.store(byteImg3, "libro3.png", "png");
        byte[] bytePdf4 = Files.readAllBytes(Paths.get("libro3-1-15.pdf"));
        String filename6 =  storageService.store(bytePdf4, "libro3-1-15.pdf", "pdf");
        String uri5 = "http://10.0.2.2:8080/download/" + filename5;
        String uri6 = "http://10.0.2.2:8080/download/" + filename6;
        Book b3 = Book.builder()
                .autorLibroPublicado(u)
                .cover(uri5)
                .name("Harry Potter y el prisionero de Azkaban")
                .description("Igual que en las dos primeras partes de la serie, Harry aguarda con impaciencia el inicio del tercer curso en el Colegio Hogwarts de Magia. Tras haber cumplido los trece años, solo y lejos de sus amigos, Harry se pelea con su bigotuda tía Marge, a la que convierte en globo, y debe huir en un autobús mágico. Mientras tanto, de la prisión de Azkaban se ha escapado un terrible villano, Sirius Black, un asesino en serie con poderes mágicos que fue cómplice de lord Voldemort y que parece dispuesto a borrar a Harry del mapa. Y por si fuera poco, Harry deberá enfrentarse también a unos terribles monstruos, los dementores, seres abominables capaces de robarle la felicidad a los magos y de eliminar todo recuerdo hermoso de aquellos que osan mirarlos. Lo que ninguno de estos malvados personajes sabe es que Harry, con la ayuda de sus fieles amigos Ron y Hermione, es capaz de todo y mucho más.")
                .genres(List.of(g))
                .build();

        Chapter c4 = Chapter.builder()
                .name("Lechuzas mensajeras")
                .file(uri6)
                .libro(b3)
                .build();

        byte[] byteImg5 = Files.readAllBytes(Paths.get("libro4.png"));
        String filename7 =  storageService.store(byteImg5, "libro4.png", "png");
        byte[] bytePdf6 = Files.readAllBytes(Paths.get("libro4-1-16.pdf"));
        String filename8 =  storageService.store(bytePdf6, "libro4-1-16.pdf", "pdf");
        String uri7 = "http://10.0.2.2:8080/download/" + filename7;
        String uri8 = "http://10.0.2.2:8080/download/" + filename8;
        Book b4 = Book.builder()
                .autorLibroPublicado(u)
                .cover(uri7)
                .name("Harry Potter y el cáliz de fuego")
                .description("Tras otro abominable verano con los Dursley, Harry se dispone a iniciar el cuarto curso en Hogwarts, la famosa escuela de magia y hechicería. A sus catorce años, a Harry le gustaría ser un joven mago como los demás y dedicarse a aprender nuevos sortilegios, encontrarse con sus amigos Ron y Hermione y asistir con ellos a los Mundiales de quidditch. Sin embargo, al llegar al colegio le espera una gran sorpresa que lo obligará a enfrentarse a los desafíos más temibles de toda su vida. SI logra superarlos, habrá demostrado que ya no es un niño y que está preparado para vivir las nuevas y emocionantes experiencias que el futuro le depara.")
                .genres(List.of(g))
                .build();

        Chapter c5 = Chapter.builder()
                .name("La Mansión de los Ryddle")
                .file(uri8)
                .libro(b4)
                .build();

        bookRepository.save(b1);
        bookRepository.save(b2);
        bookRepository.save(b3);
        bookRepository.save(b4);
        chapterRepository.save(c1);
        chapterRepository.save(c2);
        chapterRepository.save(c3);
        chapterRepository.save(c4);
        chapterRepository.save(c5);

    }

}
