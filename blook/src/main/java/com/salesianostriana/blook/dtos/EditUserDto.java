package com.salesianostriana.blook.dtos;

import com.salesianostriana.blook.validation.anotations.EditEmail;
import lombok.*;
import javax.validation.constraints.Email;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Builder
@EditEmail(nickField = "nick",
        emailField = "email",
        message = "{user.unique.email}")
public class EditUserDto {

    private String nick;
    private String name;
    private String lastname;
    @Email(message = "{user.email.email}")
    private String email;
}