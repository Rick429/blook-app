part of 'book_edit_bloc.dart';

abstract class BookEditState extends Equatable {
  const BookEditState();
  
  @override
  List<Object> get props => [];
}

class BookEditInitial extends BookEditState {}

class OneBookEditFetched extends BookEditState {
  final Book book;
  final List<Genre> genresList;
  final List<Genre> generosSeleccionados;

  const OneBookEditFetched(this.book, this.genresList, this.generosSeleccionados);

  @override
  List<Object> get props => [book];
}

class OneBookEditFetchError extends BookEditState {
  final String message;
  const OneBookEditFetchError(this.message);

  @override
  List<Object> get props => [message];
}