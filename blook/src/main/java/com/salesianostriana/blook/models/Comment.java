package com.salesianostriana.blook.models;

import lombok.*;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;
import javax.persistence.*;
import java.io.Serializable;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@AllArgsConstructor
@NoArgsConstructor
@Getter @Setter
@Builder
@EntityListeners(AuditingEntityListener.class)
public class Comment implements Serializable {

    @EmbeddedId
    @Builder.Default
    private CommentPK id = new CommentPK();

    @ManyToOne
    @MapsId("usuario_id")
    @JoinColumn(name = "usuario_id")
    private UserEntity comentador;
    @ManyToOne
    @MapsId("libro_comentado_id")
    @JoinColumn(name = "libro_comentado_id")
    private Book libroComentado;
    private String comment;
    @CreatedDate
    private LocalDate createdDate;

    /* HELPERS */

    public void addCommentToUser(UserEntity u) {
        comentador = u;
        u.getMisComentarios().add(this);
    }

    public void removeCommentFromUser(UserEntity u) {
        u.getMisComentarios().remove(this);
        comentador = null;
    }

    public void addCommentToBook(Book l) {
        libroComentado = l;
        l.getComentarios().add(this);
    }

    public void removeCommentFromBook(Book l) {
        l.getComentarios().remove(this);
        libroComentado = null;
    }

    public void addUserCommentToBook(UserEntity usuario, Book libro) {
        addCommentToUser(usuario);
        addCommentToBook(libro);
    }

    public void removeUserCommentToBook(UserEntity usuario, Book libro) {
        removeCommentFromUser(usuario);
        removeCommentFromBook(libro);
    }


}
