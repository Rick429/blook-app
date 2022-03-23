package com.salesianostriana.blook.dtos;

import lombok.*;
import javax.validation.constraints.NotBlank;
import java.time.LocalDate;

@AllArgsConstructor
@NoArgsConstructor
@Getter @Setter
@Builder
public class CreateBookDto {

    @NotBlank
    private String name;
    @NotBlank
    private String description;
    private LocalDate relase_date;
    @NotBlank
    private String cover;

}
