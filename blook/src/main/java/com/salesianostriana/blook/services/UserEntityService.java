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
    private final StorageService storageService;
    private final UserEntityRepository userEntityRepository;


    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        return this.userEntityRepository.findFirstByEmail(email)
                .orElseThrow(() -> new UsernameNotFoundException(email + " no encontrado"));
    }

    public Optional<UserEntity> findFirstByNick(String nick) {
        return userEntityRepository.findFirstByNick(nick);
    }

    public UserEntity save(CreateUserDto newUser) {
        UserEntity userEntity = UserEntity.builder()
                .password(passwordEncoder.encode(newUser.getPassword()))
                .name(newUser.getName())
                .lastname(newUser.getLastname())
                .nick(newUser.getNick())
                .email(newUser.getEmail())
                .role(UserRole.USER)
                .build();
        return userEntityRepository.save(userEntity);
    }

    public UserEntity findById(UUID id) {
        return userEntityRepository.findById(id)
                .orElseThrow(() -> new OneEntityNotFound(id.toString(), UserEntity.class));
    }

    public UserEntity uploadAvatar (MultipartFile file, UserEntity user) {
        Optional<UserEntity> u1 = userEntityRepository.findById(user.getId());
        if(u1.isEmpty()){
            throw new OneEntityNotFound(user.getId().toString(), UserEntity.class);
        }else{
            String uri = storageService.store(file);
            u1.get().setAvatar(storageService.completeUri(uri));
            return userEntityRepository.save(u1.get());
        }
    }
}
