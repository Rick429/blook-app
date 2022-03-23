package com.salesianostriana.blook.validation.validators;

import com.salesianostriana.blook.repositories.UserEntityRepository;
import com.salesianostriana.blook.validation.anotations.UniqueUsername;
import org.springframework.beans.factory.annotation.Autowired;
import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;

public class UniqueUsernameValidator implements ConstraintValidator<UniqueUsername, String> {

    @Autowired
    private UserEntityRepository repository;

    @Override
    public void initialize(UniqueUsername constraintAnnotation) { }

    @Override
    public boolean isValid(String username, ConstraintValidatorContext context) {
        return !repository.existsByUsername(username);
    }
}
