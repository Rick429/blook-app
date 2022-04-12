package com.salesianostriana.blook.errors.exceptions;

public class ListEntityNotFoundException extends EntityNotFound{

    public ListEntityNotFoundException(Class clazz) {
        super(String.format("No se pueden encontrar elementos del tipo %s ", clazz.getName()));
    }

}