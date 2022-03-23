package com.salesianostriana.blook.dtos;

import com.salesianostriana.blook.validation.anotations.PasswordsMatch;
import com.salesianostriana.blook.validation.anotations.UniqueEmail;
import com.salesianostriana.blook.validation.anotations.UniqueUsername;
import lombok.*;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;

@NoArgsConstructor
@AllArgsConstructor
@Getter @Setter
@Builder

@PasswordsMatch(passwordField = "password",
        verifyPasswordField = "password2",
        message = "{user.password.notmatch}")
public class CreateUserDto {

    @NotBlank
    @UniqueUsername(message = "{user.unique.username}")
    private String username;
    private String name;
    private String lastname;
    @NotBlank
    @Email
    @UniqueEmail(message = "{user.unique.email}")
    private String email;
    private String password;
    private String password2;

}
