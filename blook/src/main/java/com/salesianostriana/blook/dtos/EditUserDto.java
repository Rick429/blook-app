package com.salesianostriana.blook.dtos;

import com.salesianostriana.blook.validation.anotations.UniqueEmail;
import lombok.*;
import javax.validation.constraints.Email;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Builder

public class EditUserDto {

    private String name;
    private String lastname;
    @Email
    @UniqueEmail(message = "{user.unique.email}")
    private String email;
}