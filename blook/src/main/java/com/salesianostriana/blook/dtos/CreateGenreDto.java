package com.salesianostriana.blook.dtos;

import lombok.*;

@AllArgsConstructor
@NoArgsConstructor
@Getter @Setter
@Builder
public class CreateGenreDto {

    private String name;
    private String description;
}
