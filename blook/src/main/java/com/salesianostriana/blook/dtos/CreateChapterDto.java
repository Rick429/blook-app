package com.salesianostriana.blook.dtos;

import lombok.*;
import javax.validation.constraints.NotBlank;

@AllArgsConstructor
@NoArgsConstructor
@Getter @Setter
@Builder
public class CreateChapterDto {

    @NotBlank
    private String name;
    @NotBlank
    private String file;
}
