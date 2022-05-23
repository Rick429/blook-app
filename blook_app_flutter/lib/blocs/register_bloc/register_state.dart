part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();
  
  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterLoadingState extends RegisterState {}

class RegisterSuccessState extends RegisterState {
  final LoginResponse loginResponse;

  const RegisterSuccessState(this.loginResponse);

  @override
  List<Object> get props => [loginResponse];
}

class RegisterErrorState extends RegisterState {
  final Exception errorsResponse;

  const RegisterErrorState(this.errorsResponse);

  @override
  List<Object> get props => [errorsResponse];
}
