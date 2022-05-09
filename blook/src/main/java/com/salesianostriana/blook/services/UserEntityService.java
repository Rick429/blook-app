package com.salesianostriana.blook.services;

import com.salesianostriana.blook.dtos.*;
import com.salesianostriana.blook.enums.UserRole;
import com.salesianostriana.blook.errors.exceptions.ListEntityNotFoundException;
import com.salesianostriana.blook.errors.exceptions.OneEntityNotFound;
import com.salesianostriana.blook.models.Genre;
import com.salesianostriana.blook.models.UserEntity;
import com.salesianostriana.blook.repositories.UserEntityRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
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
    private final UserDtoConverter userDtoConverter;


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
                .avatar("")
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

    public UserEntity editUser(EditUserDto editUserDto, UserEntity user) {
        Optional<UserEntity> u = userEntityRepository.findById(user.getId());
        if(u.isEmpty()){
            throw new OneEntityNotFound(user.getId().toString(), UserEntity.class);
        } else {
                u.get().setNick(editUserDto.getNick());
                u.get().setName(editUserDto.getName());
                u.get().setLastname(editUserDto.getLastname());
                u.get().setEmail(editUserDto.getEmail());
            return userEntityRepository.save(u.get());
        }
    }

    public Page<GetUserDto> findAllUsers (Pageable pageable) {
        Page<UserEntity> lista = userEntityRepository.findAll(pageable);

        if(lista.isEmpty()) {
            throw new ListEntityNotFoundException(UserEntity.class);
        } else {
            return lista.map(userDtoConverter::userEntityToGetUserDto);
        }
    }

    public UserEntity changePassword(PasswordDto passwordDto, UserEntity user) {
        Optional<UserEntity> u = userEntityRepository.findById(user.getId());

        if(u.isEmpty()){
            throw new OneEntityNotFound(user.getId().toString(), UserEntity.class);
        } else {
            if(passwordEncoder.matches(passwordDto.getPassword(), user.getPassword())){
                if(passwordDto.getPasswordNew().equals(passwordDto.getPasswordNew2())){
                    u.get().setPassword(passwordEncoder.encode(passwordDto.getPasswordNew()));
                }
                return userEntityRepository.save(u.get());
            }else {
                throw new OneEntityNotFound(user.getId().toString(), UserEntity.class);
            }

        }
    }
}
