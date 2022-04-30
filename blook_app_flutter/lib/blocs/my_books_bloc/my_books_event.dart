part of 'my_books_bloc.dart';

abstract class MyBooksEvent extends Equatable {
  const MyBooksEvent();

  @override
  List<Object> get props => [];
}

class FetchAllMyBooks extends MyBooksEvent {
  final int size;
  const FetchAllMyBooks(this.size);

  @override
  List<Object> get props => [size];
}