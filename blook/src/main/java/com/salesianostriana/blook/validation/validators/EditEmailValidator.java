package com.salesianostriana.blook.validation.validators;

import com.salesianostriana.blook.repositories.UserEntityRepository;
import com.salesianostriana.blook.validation.anotations.EditEmail;
import org.springframework.beans.PropertyAccessorFactory;
import org.springframework.beans.factory.annotation.Autowired;
import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;


public class EditEmailValidator implements ConstraintValidator<EditEmail, Object> {

    private String nickField;
    private String emailField;

    @Autowired
    private UserEntityRepository repository;

    @Override
    public void initialize(EditEmail constraintAnnotation) {
        nickField = constraintAnnotation.nickField();
        emailField = constraintAnnotation.emailField();
    }

    @Override
    public boolean isValid(Object value, ConstraintValidatorContext context) {
        String nick = (String) PropertyAccessorFactory.forBeanPropertyAccess(value).getPropertyValue(nickField);
        String email = (String) PropertyAccessorFactory.forBeanPropertyAccess(value).getPropertyValue(emailField);

        return !repository.existsByEmail(email) || email.equals(repository.existsEmailWithNick(nick));


    }
}
