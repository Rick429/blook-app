package com.salesianostriana.blook.dtos;

import lombok.*;
import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

@AllArgsConstructor
@NoArgsConstructor
@Getter @Setter
@Builder
public class GetBookDto {

    private UUID id;
    private String name;
    private String description;
    private LocalDate releaseDate;
    private String cover;
    private String autor;
    private List<GetChapterDto> chapters;
    private List<GetCommentDto> comments;
}
