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

    @NotBlank(message = "{user.password.blank}")
    private String password;
    @Size(min = 8, message = "{user.password.size}")
    @NotBlank(message = "{user.password.blank}")
    private String passwordNew;
    @Size(min = 8, message = "{user.password.size}")
    @NotBlank(message = "{user.password.blank}")
    private String passwordNew2;
}
