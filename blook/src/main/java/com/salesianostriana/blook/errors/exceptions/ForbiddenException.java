package com.salesianostriana.blook.errors.exceptions;

public class ForbiddenException extends RuntimeException{

    public ForbiddenException(String message) {
        super(String.format(message));
    }

}
