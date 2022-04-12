package com.salesianostriana.blook.errors.exceptions;

public class UnauthorizedException extends RuntimeException{

    public UnauthorizedException(String message) {
        super(String.format(message));
    }

}
