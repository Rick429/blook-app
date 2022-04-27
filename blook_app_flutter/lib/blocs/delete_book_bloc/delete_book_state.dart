part of 'delete_book_bloc.dart';

abstract class DeleteBookState extends Equatable {
  const DeleteBookState();
  
  @override
  List<Object> get props => [];
}

class DeleteBookInitial extends DeleteBookState {}

class DeleteSuccessState extends DeleteBookState {

  const DeleteSuccessState();

  @override
  List<Object> get props => [];
}

class DeleteErrorState extends DeleteBookState {
  final String message;

  const DeleteErrorState(this.message);

  @override
  List<Object> get props => [message];
}