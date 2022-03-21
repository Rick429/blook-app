package com.salesianostriana.blook.dtos;

import com.salesianostriana.blook.models.UserEntity;
import com.salesianostriana.blook.security.dto.LoginDto;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class UserDtoConverter {

    public LoginDto createUserDtoToLoginDto(CreateUserDto cu){
        return LoginDto.builder()
                .username(cu.getNick())
                .password(cu.getPassword())
                .build();
    }

    public GetUserDto UserEntityToGetUserDto(UserEntity u) {
        return GetUserDto.builder()
                .name(u.getName())
                .lastname(u.getLastname())
                .avatar(u.getAvatar())
                .email(u.getEmail())
                .username(u.getUsername())
                .role(u.getRole())
                .build();
    }

}