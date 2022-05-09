part of 'change_password_bloc.dart';

abstract class ChangePasswordState extends Equatable {
  const ChangePasswordState();
  
  @override
  List<Object> get props => [];
}

class ChangePasswordInitial extends ChangePasswordState {}

class ChangePasswordSuccessState extends ChangePasswordState {
  final User user;

  const ChangePasswordSuccessState( this.user);

  @override
  List<Object> get props => [user];
}

class ChangePasswordErrorState extends ChangePasswordState {
  final String message;

  const ChangePasswordErrorState(this.message);

  @override
  List<Object> get props => [message];
}