package com.salesianostriana.blook.models;

import lombok.*;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Parameter;
import javax.persistence.*;
import java.io.Serializable;
import java.util.UUID;

@Entity
@AllArgsConstructor
@NoArgsConstructor
@Getter @Setter
@Builder
public class Genre implements Serializable {

    @Id
    @GeneratedValue(generator = "UUID")
    @GenericGenerator(
            name = "UUID",
            strategy = "org.hibernate.id.UUIDGenerator",
            parameters = {
                    @Parameter(
                            name = "uuid_gen_strategy_class",
                            value = "org.hibernate.id.uuid.CustomVersionOneStrategy"
                    )
            }
    )
    @Column(name = "id", updatable = false, nullable = false)
    private UUID id;
    private String name;
    private String description;
    @ManyToOne
    @JoinColumn(name = "genre_book_id")
    private Book genreBook;


    /** HELPERS **/

    public void addGenreToBook(Book book) {
        genreBook = book;
        book.getGenres().add(this);
    }

    public void removeGenreFromBook(Book book) {
        book.getGenres().remove(this);
        genreBook = null;
    }
}
