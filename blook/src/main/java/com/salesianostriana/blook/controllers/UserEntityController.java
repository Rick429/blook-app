package com.salesianostriana.blook.controllers;

import com.salesianostriana.blook.dtos.GetUserDto;
import com.salesianostriana.blook.dtos.UserDtoConverter;
import com.salesianostriana.blook.models.UserEntity;
import com.salesianostriana.blook.services.UserEntityService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

@RestController
@RequiredArgsConstructor
@RequestMapping("/user")
public class UserEntityController {

    private final UserEntityService userEntityService;
    private final UserDtoConverter userDtoConverter;

    @PostMapping("/avatar/")
    public ResponseEntity<GetUserDto> uploadAvatar(@RequestPart("file")MultipartFile file,
                                                   @AuthenticationPrincipal UserEntity user) {
        return ResponseEntity.status(HttpStatus.OK).body(userDtoConverter
                .UserEntityToGetUserDto(userEntityService.uploadAvatar(file, user)));

    }
}
