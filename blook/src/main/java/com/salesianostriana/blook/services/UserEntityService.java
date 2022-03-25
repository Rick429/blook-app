package com.salesianostriana.blook.services;

import com.salesianostriana.blook.dtos.CreateUserDto;
import com.salesianostriana.blook.enums.UserRole;
import com.salesianostriana.blook.errors.exceptions.OneEntityNotFound;
import com.salesianostriana.blook.models.UserEntity;
import com.salesianostriana.blook.repositories.UserEntityRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.Optional;
import java.util.UUID;

@Service("userDetailsService")
@RequiredArgsConstructor
public class UserEntityService implements UserDetailsService {

    private final PasswordEncoder passwordEncoder;
    private final UserEntityRepository userEntityRepository;


    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        return this.userEntityRepository.findFirstByUsername(username)
                .orElseThrow(() -> new UsernameNotFoundException(username + " no encontrado"));
    }

    public Optional<UserEntity> findFirstByUsername(String username) {
        return userEntityRepository.findFirstByUsername(username);
    }

    public UserEntity save(CreateUserDto newUser, MultipartFile avatar) {
        String uri = "";
        UserEntity userEntity = UserEntity.builder()
                .password(passwordEncoder.encode(newUser.getPassword()))
                .avatar(uri)
                .name(newUser.getName())
                .lastname(newUser.getLastname())
                .username(newUser.getUsername())
                .email(newUser.getEmail())
                .role(UserRole.USER)
                .build();
        return userEntityRepository.save(userEntity);
    }

    public UserEntity findById(UUID id) {
        return userEntityRepository.findById(id)
                .orElseThrow(() -> new OneEntityNotFound(id.toString(), UserEntity.class));
    }
}
