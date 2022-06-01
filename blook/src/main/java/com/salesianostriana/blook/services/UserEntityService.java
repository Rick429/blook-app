package com.salesianostriana.blook.services;

import com.salesianostriana.blook.dtos.*;
import com.salesianostriana.blook.enums.Estado;
import com.salesianostriana.blook.enums.TypeReport;
import com.salesianostriana.blook.enums.UserRole;
import com.salesianostriana.blook.errors.exceptions.ForbiddenException;
import com.salesianostriana.blook.errors.exceptions.ListEntityNotFoundException;
import com.salesianostriana.blook.errors.exceptions.OneEntityNotFound;
import com.salesianostriana.blook.models.Genre;
import com.salesianostriana.blook.models.Report;
import com.salesianostriana.blook.models.UserEntity;
import com.salesianostriana.blook.repositories.UserEntityRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.security.core.userdetails.User;
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

    public UserEntity uploadAvatar (MultipartFile file, UserEntity user, UUID id) {
        Optional<UserEntity> u1 = userEntityRepository.findById(id);
        if(u1.isEmpty()){
            throw new OneEntityNotFound(user.getId().toString(), UserEntity.class);
        }else{
            if(user.getId().equals(id) || user.getRole().equals(UserRole.ADMIN)) {
                String uri = storageService.store(file);
                u1.get().setAvatar(storageService.completeUri(uri));
                return userEntityRepository.save(u1.get());
            } else {
                throw new ForbiddenException("Permisos insuficientes");
            }
        }
    }

    public UserEntity editUser(EditUserDto editUserDto, UserEntity user, UUID id) {
        Optional<UserEntity> u = userEntityRepository.findById(id);
        if(u.isEmpty()){
            throw new OneEntityNotFound(user.getId().toString(), UserEntity.class);
        } else {
            if(user.getId().equals(id) || user.getRole().equals(UserRole.ADMIN)) {
                u.get().setName(editUserDto.getName());
                u.get().setLastname(editUserDto.getLastname());
                if(editUserDto.getEmail()!=null) {
                    u.get().setEmail(editUserDto.getEmail());
                }
                return userEntityRepository.save(u.get());
            } else {
                throw new ForbiddenException("Permisos insuficientes");
            }
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

    public UserEntity giveAdmin (UserEntity user, UUID idUser){
        if(user.getRole().equals(UserRole.ADMIN)){
            Optional<UserEntity> u = userEntityRepository.findById(idUser);
            if(u.isPresent()){
                u.get().setRole(UserRole.ADMIN);
                return userEntityRepository.save(u.get());
            } else {
                throw new OneEntityNotFound(idUser.toString(), UserEntity.class);
            }
        }else{
            throw new ForbiddenException("No tiene permisos para realizar esta acción");
        }
    }

    public UserEntity removeAdmin (UserEntity user, UUID idUser){
        if(user.getRole().equals(UserRole.ADMIN)){
            Optional<UserEntity> u = userEntityRepository.findById(idUser);
            if(u.isPresent()){
                u.get().setRole(UserRole.USER);
                return userEntityRepository.save(u.get());
            } else {
                throw new OneEntityNotFound(idUser.toString(), UserEntity.class);
            }
        }else{
            throw new ForbiddenException("No tiene permisos para realizar esta acción");
        }
    }

    public Page<GetUserDto> buscarUser(UserEntity user, BuscarUserDto u, Pageable pageable){
        if(user.getRole().equals(UserRole.ADMIN)){
            Page<UserEntity> lista = buscar(Optional.ofNullable(u.getNick()),
                    Optional.ofNullable(u.getName()),
                    Optional.ofNullable(u.getLastname()),
                            Optional.ofNullable(u.getEmail()),
                            Optional.ofNullable(u.getRole()),
                            pageable);

            if(lista.isEmpty()){
                throw new ListEntityNotFoundException(Report.class);
            } else {
                return lista.map(userDtoConverter::userEntityToGetUserDto);
            }
        }else{
            throw new ForbiddenException("No tiene permisos para realizar esta acción");
        }
    }



    private Page<UserEntity> buscar(Optional<String> nick, Optional<String> name,Optional<String> lastname,Optional<String> email
            , Optional<UserRole> role, Pageable pageable) {
        Specification<UserEntity> specNick = (root, query, criteriaBuilder) -> {
            if (nick.isPresent()) {
                return criteriaBuilder.like(criteriaBuilder.lower(root.get("nick")), "%" + nick.get().toLowerCase() + "%");
            } else {
                return criteriaBuilder.isTrue(criteriaBuilder.literal(true));
            }
        };

        Specification<UserEntity> specName = (root, query, criteriaBuilder) -> {
            if (name.isPresent()) {
                return criteriaBuilder.like(criteriaBuilder.lower(root.get("name")), "%" + name.get().toLowerCase() + "%");
            } else {
                return criteriaBuilder.isTrue(criteriaBuilder.literal(true));
            }
        };

        Specification<UserEntity> specLastName = (root, query, criteriaBuilder) -> {
            if (lastname.isPresent()) {
                return criteriaBuilder.like(criteriaBuilder.lower(root.get("lastname")), "%" + lastname.get().toLowerCase() + "%");
            } else {
                return criteriaBuilder.isTrue(criteriaBuilder.literal(true));
            }
        };

        Specification<UserEntity> specEmail = (root, query, criteriaBuilder) -> {
            if (email.isPresent()) {
                return criteriaBuilder.like(criteriaBuilder.lower(root.get("email")), "%" + email.get().toLowerCase() + "%");
            } else {
                return criteriaBuilder.isTrue(criteriaBuilder.literal(true));
            }
        };

        Specification<UserEntity> specRole = (root, query, criteriaBuilder) -> {
            if (role.isPresent()) {
                return criteriaBuilder.equal(root.get("role"), role.get());
            } else {
                return criteriaBuilder.isTrue(criteriaBuilder.literal(true));
            }

        };
        Specification<UserEntity> todas =
                specNick
                        .or(specName)
                        .or(specLastName)
                        .or(specEmail)
                        .or(specRole);

        return this.userEntityRepository.findAll(todas, pageable);
    }
}
