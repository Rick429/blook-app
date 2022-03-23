package com.salesianostriana.blook.validation.validators;

import com.salesianostriana.blook.repositories.UserEntityRepository;
import com.salesianostriana.blook.validation.anotations.UniqueEmail;
import org.springframework.beans.factory.annotation.Autowired;
import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;

public class UniqueEmailValidator implements ConstraintValidator<UniqueEmail, String> {

    @Autowired
    private UserEntityRepository repository;

    @Override
    public void initialize(UniqueEmail constraintAnnotation) { }

    @Override
    public boolean isValid(String email, ConstraintValidatorContext context) {
        return !repository.existsByEmail(email);
    }


}