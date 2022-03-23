package com.salesianostriana.blook.dtos;

import lombok.*;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Builder
public class GetChapterDto {

    private String name;
    private String file;

}
