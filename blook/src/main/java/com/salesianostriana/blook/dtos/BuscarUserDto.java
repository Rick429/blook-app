package com.salesianostriana.blook.dtos;

import com.salesianostriana.blook.enums.UserRole;
import lombok.*;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Builder
public class BuscarUserDto {

    private String nick;
    private String name;
    private String lastname;
    private String email;
    private UserRole role;
}
