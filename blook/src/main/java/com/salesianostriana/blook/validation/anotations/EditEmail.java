package com.salesianostriana.blook.validation.anotations;

import com.salesianostriana.blook.validation.validators.EditEmailValidator;
import javax.validation.Constraint;
import javax.validation.Payload;
import java.lang.annotation.*;

@Constraint(validatedBy = EditEmailValidator.class)
@Target({ElementType.TYPE})
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface EditEmail {

    String message() default "El email debe ser unico";
    Class <?> [] groups() default {};
    Class <? extends Payload> [] payload() default {};

    String nickField();
    String emailField();
}
