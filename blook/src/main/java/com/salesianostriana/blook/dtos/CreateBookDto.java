package com.salesianostriana.blook.dtos;

import com.salesianostriana.blook.models.Genre;
import lombok.*;
import org.springframework.data.annotation.CreatedDate;

import javax.validation.constraints.NotBlank;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

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
    private List<Genre> generos = new ArrayList<>();

}
