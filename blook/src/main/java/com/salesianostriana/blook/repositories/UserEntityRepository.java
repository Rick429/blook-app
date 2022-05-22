package com.salesianostriana.blook.repositories;

import com.salesianostriana.blook.models.UserEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.Optional;
import java.util.UUID;

public interface UserEntityRepository extends JpaRepository<UserEntity, UUID> {

    Optional<UserEntity> findFirstByNick(String nick);

    Optional<UserEntity> findFirstByEmail(String email);

    boolean existsByNick(String nick);

    boolean existsByEmail(String email);

    @Query("SELECT u.email FROM UserEntity u WHERE u.nick = :nick")
    String existsEmailWithNick(String nick);
}
