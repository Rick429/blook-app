package com.salesianostriana.blook.dtos;

import com.salesianostriana.blook.validation.anotations.PasswordsMatch;
import lombok.*;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

@AllArgsConstructor
@NoArgsConstructor
@Getter @Setter
@Builder
@PasswordsMatch(passwordField = "passwordNew",
        verifyPasswordField = "passwordNew2",
        message = "{user.password.notmatch}")
public class PasswordDto {

    @NotBlank
    private String password;
    @Size(min = 8)
    @NotBlank
    private String passwordNew;
    @Size(min = 8)
    @NotBlank
    private String passwordNew2;
}
