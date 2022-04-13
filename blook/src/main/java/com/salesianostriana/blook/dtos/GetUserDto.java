package com.salesianostriana.blook.dtos;

import com.salesianostriana.blook.enums.UserRole;
import lombok.*;
import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

@AllArgsConstructor
@NoArgsConstructor
@Getter @Setter
@Builder
public class GetUserDto {

    private UUID id;
    private String nick;
    private String name;
    private String lastname;
    private String email;
    private String avatar;
    private UserRole role;
    private List<GetBookDto> libros;
}
