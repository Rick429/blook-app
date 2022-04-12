package com.salesianostriana.blook.security.dto;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class JwtUserResponse {

    private String nick;
    private String name, lastname;
    private String email;
    private String avatar;
    private String role;
    private String token;

}