package com.salesianostriana.blook.models;

import lombok.*;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Parameter;

import javax.persistence.*;
import java.io.Serializable;
import java.util.UUID;

@Entity
@Getter @Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Chapter implements Serializable {

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
    private String file;

    @ManyToOne
    @JoinColumn(name = "libro_id")
    private Book libro;

    /* HELPERS */
    public void addChapterToBook(Book b) {
        libro = b;
        b.getChapters().add(this);
    }

    public void removeChapterFromBook(Book b) {
        b.getChapters().remove(this);
        libro = null;
    }

}
