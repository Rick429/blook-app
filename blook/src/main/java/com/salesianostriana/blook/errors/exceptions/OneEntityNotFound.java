package com.salesianostriana.blook.errors.exceptions;

public class OneEntityNotFound extends EntityNotFound {

    public OneEntityNotFound(String id, Class clazz) {
        super(String.format("No se puede encontrar una entidad del tipo %s con ID: %s", clazz.getName(), id));
    }
}
