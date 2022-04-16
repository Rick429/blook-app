package com.salesianostriana.blook.dtos;

import com.salesianostriana.blook.models.UserEntity;
import com.salesianostriana.blook.security.dto.LoginDto;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import java.util.stream.Collectors;

@Component
@RequiredArgsConstructor
public class UserDtoConverter {

    private final BookDtoConverter bookDtoConverter;

    public LoginDto createUserDtoToLoginDto(CreateUserDto cu){
        return LoginDto.builder()
                .email(cu.getEmail())
                .password(cu.getPassword())
                .build();
    }

    public GetUserDto userEntityToGetUserDto(UserEntity u) {
        return GetUserDto.builder()
                .id(u.getId())
                .nick(u.getNick())
                .name(u.getName())
                .lastname(u.getLastname())
                .avatar(u.getAvatar())
                .email(u.getEmail())
                .role(u.getRole())
                .libros(u.getMisLibros().stream().map(bookDtoConverter::bookToGetBookDto).collect(Collectors.toList()))
                .build();
    }

}