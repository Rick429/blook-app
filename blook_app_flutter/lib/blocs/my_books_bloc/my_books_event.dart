part of 'my_books_bloc.dart';

abstract class MyBooksEvent extends Equatable {
  const MyBooksEvent();

  @override
  List<Object> get props => [];
}

class FetchAllMyBooks extends MyBooksEvent {

  const FetchAllMyBooks();

  @override
  List<Object> get props => [];
}