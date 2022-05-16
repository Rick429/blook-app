package com.salesianostriana.blook.security;

import com.salesianostriana.blook.dtos.CreateUserDto;
import com.salesianostriana.blook.dtos.UserDtoConverter;
import com.salesianostriana.blook.models.UserEntity;
import com.salesianostriana.blook.security.dto.JwtUserResponse;
import com.salesianostriana.blook.security.dto.LoginDto;
import com.salesianostriana.blook.security.jwt.JwtProvider;
import com.salesianostriana.blook.services.UserEntityService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import javax.validation.Valid;
import java.util.Optional;

@RestController
@RequiredArgsConstructor
public class AuthenticationController {

    private final AuthenticationManager authenticationManager;
    private final JwtProvider jwtProvider;
    private final UserEntityService userEntityService;
    private final UserDtoConverter userDtoConverter;

    @Operation(summary = "Se hace login")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201",
                    description = "Se hace login",
                    content = {@Content(mediaType = "aplication/json",
                            schema = @Schema(implementation = UserEntity.class))}),
            @ApiResponse(responseCode = "400",
                    description = "Error en los datos",
                    content = @Content),
    })
    @PostMapping("/blook/auth/login")
    public ResponseEntity<?> login(@RequestBody LoginDto loginDto) {

        return ResponseEntity.status(HttpStatus.CREATED)
                .body(loginUser(loginDto));

    }
    @Operation(summary = "Se muestra los datos del usuario logueado")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Se hace login",
                    content = {@Content(mediaType = "aplication/json",
                            schema = @Schema(implementation = UserEntity.class))}),
    })
    @GetMapping("/blook/me")
    public ResponseEntity<?> quienSoyYo(@AuthenticationPrincipal UserEntity user) {
        Optional<UserEntity> u = userEntityService.findFirstByNick(user.getNick());
        return ResponseEntity.ok(userDtoConverter.userEntityToGetUserDto(u.get()));
    }

    private JwtUserResponse convertUserToJwtUserResponse(UserEntity user, String jwt) {
        return JwtUserResponse.builder()
                .nick(user.getNick())
                .email(user.getEmail())
                .name(user.getName())
                .lastname(user.getLastname())
                .avatar(user.getAvatar())
                .role(user.getRole().name())
                .token(jwt)
                .build();
    }

    @Operation(summary = "Registra nuevo usuario y hace login")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201",
                    description = "Se registra el usuario y se hace login",
                    content = {@Content(mediaType = "aplication/json",
                            schema = @Schema(implementation = UserEntity.class))}),
            @ApiResponse(responseCode = "400",
                    description = "Error en los datos",
                    content = @Content),
    })
    @PostMapping("/blook/auth/register")
    public ResponseEntity<?> nuevoUsuario(@Valid @RequestPart("user") CreateUserDto newUser) {

        UserEntity saved = userEntityService.save(newUser);

        if (saved == null)
            return ResponseEntity.badRequest().build();
        else
            return ResponseEntity.status(HttpStatus.CREATED).body(this.loginUser(userDtoConverter.createUserDtoToLoginDto(newUser)));
    }

    private JwtUserResponse loginUser(LoginDto loginDto) {

        Authentication authentication =
                authenticationManager.authenticate(
                        new UsernamePasswordAuthenticationToken(
                                loginDto.getEmail(),
                                loginDto.getPassword()
                        )
                );

        SecurityContextHolder.getContext().setAuthentication(authentication);

        String jwt = jwtProvider.generateToken(authentication);

        UserEntity user = (UserEntity) authentication.getPrincipal();

        return convertUserToJwtUserResponse(user, jwt);

    }
}