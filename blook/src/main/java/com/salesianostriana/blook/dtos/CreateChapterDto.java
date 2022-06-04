package com.salesianostriana.blook.dtos;

import lombok.*;
import javax.validation.constraints.NotBlank;

@AllArgsConstructor
@NoArgsConstructor
@Getter @Setter
@Builder
public class CreateChapterDto {

    @NotBlank(message = "{chapter.name.blank}")
    private String name;

}
