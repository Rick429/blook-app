part of 'my_books_bloc.dart';

abstract class MyBooksState extends Equatable {
  const MyBooksState();
  
  @override
  List<Object> get props => [];
}

class MyBooksInitial extends MyBooksState {}

class MyBooksFetched extends MyBooksState {
  final List<Book> mybooks;

  const MyBooksFetched(this.mybooks);

  @override
  List<Object> get props => [mybooks];
}

class MyBooksFetchError extends MyBooksState {
  final String message;
  const MyBooksFetchError(this.message);

  @override
  List<Object> get props => [message];
}