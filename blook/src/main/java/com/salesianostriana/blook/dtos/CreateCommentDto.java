package com.salesianostriana.blook.dtos;

import lombok.*;

import java.util.UUID;

@AllArgsConstructor
@NoArgsConstructor
@Getter @Setter
@Builder
public class CreateCommentDto {

    private String comment;

}
