package com.salesianostriana.blook.models;

import lombok.*;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Parameter;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;
import java.io.Serializable;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@EntityListeners(AuditingEntityListener.class)
@Entity
@Getter @Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Book implements Serializable {

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
    @CreatedDate
    private LocalDate relase_date;
    private String cover;
    @Builder.Default
    @OneToMany(mappedBy = "libro")
    private List<Chapter> chapters = new ArrayList<>();

    @ManyToOne
    @JoinColumn(name = "autor_libro_publicado_id")
    private UserEntity autorLibroPublicado;

    @ManyToOne
    @JoinColumn(name = "user_libro_favorito_id")
    private UserEntity userLibroFavorito;

    @Builder.Default
    @OneToMany(mappedBy = "libroComentado", orphanRemoval = true)
    private List<Comment> comentarios = new ArrayList<>();

    @Builder.Default
    @ManyToMany
    @JoinTable(joinColumns = @JoinColumn(name = "book_id",
            foreignKey = @ForeignKey(name="FK_GENRES_BOOK")),
            inverseJoinColumns = @JoinColumn(name = "genre_id",
                    foreignKey = @ForeignKey(name="FK_BOOKS_GENRE")),
            name = "genres"
    )
    private List<Genre> genres = new ArrayList<>();

    /* HELPERS */
    public void addBookToUser(UserEntity u) {
        autorLibroPublicado = u;
        u.getMisLibros().add(this);
    }

    public void removeBookFromUser(UserEntity u) {
        u.getMisLibros().remove(this);
        autorLibroPublicado = null;
    }

    public void addBookFavoriteToUser(UserEntity u) {
        userLibroFavorito = u;
        u.getMisFavoritos().add(this);
    }

    public void removeBookFavoriteFromUser(UserEntity u) {
        u.getMisFavoritos().remove(this);
        userLibroFavorito = null;
    }

}
