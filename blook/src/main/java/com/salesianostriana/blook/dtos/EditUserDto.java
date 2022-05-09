package com.salesianostriana.blook.dtos;

import com.salesianostriana.blook.validation.anotations.PasswordsMatch;
import com.salesianostriana.blook.validation.anotations.UniqueEmail;
import com.salesianostriana.blook.validation.anotations.UniqueUsername;
import lombok.*;
import javax.validation.constraints.Email;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Builder

@PasswordsMatch(passwordField = "password",
        verifyPasswordField = "password2",
        message = "{user.password.notmatch}")
public class EditUserDto {

    @UniqueUsername(message = "{user.unique.nick}")
    private String nick;
    private String name;
    private String lastname;
    @Email
    @UniqueEmail(message = "{user.unique.email}")
    private String email;
}
