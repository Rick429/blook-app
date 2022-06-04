package com.salesianostriana.blook.dtos;

import lombok.*;

import javax.validation.constraints.NotBlank;
import java.util.UUID;

@AllArgsConstructor
@NoArgsConstructor
@Getter @Setter
@Builder
public class CreateCommentDto {

    @NotBlank(message = "{comment.comment.blank}")
    private String comment;

}
