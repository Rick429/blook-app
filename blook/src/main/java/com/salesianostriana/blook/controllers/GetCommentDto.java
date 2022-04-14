package com.salesianostriana.blook.controllers;

import lombok.*;

import java.time.LocalDate;
import java.util.UUID;

@AllArgsConstructor
@NoArgsConstructor
@Getter @Setter
@Builder
public class GetCommentDto {

    private String comment;
    private UUID user_id;
    private String nick;
    private String avatar;
    private UUID book_id;
    private LocalDate created_date;

}
