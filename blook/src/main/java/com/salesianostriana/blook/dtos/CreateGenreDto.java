package com.salesianostriana.blook.dtos;

import lombok.*;

import javax.validation.constraints.NotBlank;

@AllArgsConstructor
@NoArgsConstructor
@Getter @Setter
@Builder
public class CreateGenreDto {

    @NotBlank(message = "{genre.name.blank}")
    private String name;
    private String description;
}
