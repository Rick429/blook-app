package com.salesianostriana.blook.dtos;

import lombok.*;

@NoArgsConstructor
@AllArgsConstructor
@Getter @Setter
@Builder

public class CreateUserDto {

    private String username;
    private String name;
    private String lastname;
    private String email;
    private String password;
    private String password2;

}
