part of 'books_bloc.dart';

abstract class BooksState extends Equatable {
  const BooksState();
  
  @override
  List<Object> get props => [];
}

class BooksInitial extends BooksState {}

class BooksFetched extends BooksState {
  final List<Book> books;
  final String type;

  const BooksFetched(this.books, this.type);

  @override
  List<Object> get props => [books];
}

class BooksFetchError extends BooksState {
  final String message;
  const BooksFetchError(this.message);

  @override
  List<Object> get props => [message];
}