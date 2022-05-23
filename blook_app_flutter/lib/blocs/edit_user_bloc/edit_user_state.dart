part of 'edit_user_bloc.dart';

abstract class EditUserState extends Equatable {
  const EditUserState();
  
  @override
  List<Object> get props => [];
}

class EditUserInitial extends EditUserState {}

class EditUserSuccessState extends EditUserState {
  final User user;

  const EditUserSuccessState( this.user);

  @override
  List<Object> get props => [user];
}

class EditUserErrorState extends EditUserState {
  final String message;

  const EditUserErrorState(this.message);

  @override
  List<Object> get props => [message];
}