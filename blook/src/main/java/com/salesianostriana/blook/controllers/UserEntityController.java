package com.salesianostriana.blook.controllers;

import com.salesianostriana.blook.dtos.EditUserDto;
import com.salesianostriana.blook.dtos.GetUserDto;
import com.salesianostriana.blook.dtos.UserDtoConverter;
import com.salesianostriana.blook.models.UserEntity;
import com.salesianostriana.blook.services.UserEntityService;
import com.salesianostriana.blook.utils.PaginationLinksUtils;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.util.UriComponentsBuilder;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

@RestController
@RequiredArgsConstructor
@RequestMapping("/user")
public class UserEntityController {

    private final UserEntityService userEntityService;
    private final UserDtoConverter userDtoConverter;
    private final PaginationLinksUtils paginationLinksUtils;

    @Operation(summary = "Subir avatar")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201",
                    description = "Se sube el avatar correctamente",
                    content = {@Content(mediaType = "aplication/json",
                            schema = @Schema(implementation = UserEntity.class))}),
            @ApiResponse(responseCode = "404",
                    description = "No se encontro a usuario",
                    content = @Content),
    })
    @PostMapping("/avatar/")
    public ResponseEntity<GetUserDto> uploadAvatar(@RequestPart("file")MultipartFile file,
                                                   @AuthenticationPrincipal UserEntity user) {
        return ResponseEntity.status(HttpStatus.OK).body(userDtoConverter
                .userEntityToGetUserDto(userEntityService.uploadAvatar(file, user)));

    }

    @Operation(summary = "Editar un usuario")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Se edita el usuario correctamente",
                    content = {@Content(mediaType = "aplication/json",
                            schema = @Schema(implementation = UserEntity.class))}),
            @ApiResponse(responseCode = "400",
                    description = "Error en los datos",
                    content = @Content),
            @ApiResponse(responseCode = "404",
                    description = "No se encontró el usuario",
                    content = @Content),
    })
    @PutMapping("/")
    public GetUserDto editUser(@Valid @RequestPart("user") EditUserDto e,
                                    @AuthenticationPrincipal UserEntity user) {
        return userDtoConverter.userEntityToGetUserDto(userEntityService.editUser(e, user));
    }

    @Operation(summary = "Listar todos los usuarios")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Se devuelve una lista con todos los usuarios",
                    content = {@Content(mediaType = "aplication/json",
                            schema = @Schema(implementation = UserEntity.class))}),
            @ApiResponse(responseCode = "404",
                    description = "La lista esta vacia",
                    content = @Content),
    })
    @GetMapping("/all")
    public ResponseEntity<Page<GetUserDto>> findAllUsers (@PageableDefault(size = 10, page = 0) Pageable pageable,
                                                          @AuthenticationPrincipal UserEntity user,
                                                          HttpServletRequest request) {
        Page<GetUserDto> lista = userEntityService.findAllUsers(pageable);
        UriComponentsBuilder uriBuilder = UriComponentsBuilder.fromHttpUrl(request.getRequestURL().toString());
        return ResponseEntity.ok().header("link", paginationLinksUtils.createLinkHeader(lista, uriBuilder)).body(lista);
    }
}
