part of 'edit_book_bloc.dart';

abstract class EditBookState extends Equatable {
  const EditBookState();
  
  @override
  List<Object> get props => [];
}

class EditBookInitial extends EditBookState {}

class EditBookSuccessState extends EditBookState {
  final String pickedFile;
  final Book book;

  const EditBookSuccessState(this.pickedFile, this.book);

  @override
  List<Object> get props => [pickedFile, book];
}

class EditBookErrorState extends EditBookState {
  final ErrorResponse error;

  const EditBookErrorState(this.error);

  @override
  List<Object> get props => [error];
}