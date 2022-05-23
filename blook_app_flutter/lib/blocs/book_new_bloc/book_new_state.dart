part of 'book_new_bloc.dart';

abstract class BookNewState extends Equatable {
  const BookNewState();
  
  @override
  List<Object> get props => [];
}

class BookNewInitial extends BookNewState {}

class CreateBookSuccessState extends BookNewState {
  final String pickedFile;
  final Book book;

  const CreateBookSuccessState(this.pickedFile, this.book);

  @override
  List<Object> get props => [pickedFile, book];
}

class CreateBookErrorState extends BookNewState {
  final String message;

  const CreateBookErrorState(this.message);

  @override
  List<Object> get props => [message];
}