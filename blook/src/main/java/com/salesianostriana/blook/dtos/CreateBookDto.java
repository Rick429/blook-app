package com.salesianostriana.blook.dtos;

import lombok.*;
import org.springframework.data.annotation.CreatedDate;

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
    private String cover;

}
