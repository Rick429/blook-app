part of 'book_bloc.dart';

abstract class BookState extends Equatable {
  const BookState();
  
  @override
  List<Object> get props => [];
}

class BookInitial extends BookState {}

class OneBookFetched extends BookState {
  final Book book;

  const OneBookFetched(this.book);

  @override
  List<Object> get props => [book];
}

class OneBookFetchError extends BookState {
  final String message;
  const OneBookFetchError(this.message);

  @override
  List<Object> get props => [message];
}