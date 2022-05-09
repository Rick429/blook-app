package com.salesianostriana.blook.dtos;

import lombok.*;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

@AllArgsConstructor
@NoArgsConstructor
@Getter @Setter
@Builder
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
