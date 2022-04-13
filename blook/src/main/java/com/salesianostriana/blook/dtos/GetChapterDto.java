package com.salesianostriana.blook.dtos;

import lombok.*;

import java.util.UUID;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Builder
public class GetChapterDto {

    private UUID id;
    private String name;
    private String file;

}
