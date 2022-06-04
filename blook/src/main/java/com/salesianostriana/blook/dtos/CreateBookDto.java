package com.salesianostriana.blook.dtos;

import com.salesianostriana.blook.models.Genre;
import lombok.*;
import org.springframework.data.annotation.CreatedDate;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@AllArgsConstructor
@NoArgsConstructor
@Getter @Setter
@Builder
public class CreateBookDto {

    @NotBlank(message = "{book.name.blank}")
    private String name;
    @NotBlank(message = "{book.description.blank}")
    private String description;
    private LocalDate relase_date;
    @NotEmpty(message = "{book.genre.list.empty}")
    private List<Genre> generos = new ArrayList<>();

}
