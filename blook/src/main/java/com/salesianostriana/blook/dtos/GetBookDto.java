package com.salesianostriana.blook.dtos;

import lombok.*;
import java.time.LocalDate;
import java.util.UUID;

@AllArgsConstructor
@NoArgsConstructor
@Getter @Setter
@Builder
public class GetBookDto {

    private UUID id;
    private String name;
    private String description;
    private LocalDate relase_date;
    private String cover;
}
