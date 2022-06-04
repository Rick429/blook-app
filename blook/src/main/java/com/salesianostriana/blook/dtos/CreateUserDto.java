package com.salesianostriana.blook.dtos;

import com.salesianostriana.blook.validation.anotations.PasswordsMatch;
import com.salesianostriana.blook.validation.anotations.UniqueEmail;
import com.salesianostriana.blook.validation.anotations.UniqueUsername;
import lombok.*;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

@NoArgsConstructor
@AllArgsConstructor
@Getter @Setter
@Builder

@PasswordsMatch(passwordField = "password",
        verifyPasswordField = "password2",
        message = "{user.password.notmatch}")
public class CreateUserDto {

    @NotBlank(message = "{user.nick.blank}")
    @UniqueUsername(message = "{user.unique.nick}")
    private String nick;
    private String name;
    private String lastname;
    @NotBlank(message = "{user.email.blank}")
    @Email(message = "{user.email.email}")
    @UniqueEmail(message = "{user.unique.email}")
    private String email;
    @Size(min = 8, message = "{user.password.size}")
    private String password;
    @Size(min = 8, message = "{user.password.size}")
    private String password2;

}
