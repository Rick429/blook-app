package com.salesianostriana.blook.dtos;

import lombok.*;
import java.util.UUID;

@AllArgsConstructor
@NoArgsConstructor
@Getter @Setter
@Builder
public class GetGenreDto {

    private UUID id;
    private String name;
    private String description;

}
