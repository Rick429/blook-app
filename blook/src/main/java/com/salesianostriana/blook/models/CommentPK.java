package com.salesianostriana.blook.models;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import javax.persistence.Embeddable;
import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.UUID;

@Embeddable
@NoArgsConstructor
@AllArgsConstructor
@Getter @Setter
public class CommentPK implements Serializable {

    private UUID usuario_id;

    private UUID libro_comentado_id;

}
