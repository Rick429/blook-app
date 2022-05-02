part of 'my_books_bloc.dart';

abstract class MyBooksEvent extends Equatable {
  const MyBooksEvent();

  @override
  List<Object> get props => [];
}

class FetchAllMyBooks extends MyBooksEvent {
  final int size;
  final String sortedList;
  const FetchAllMyBooks(this.size, this.sortedList);

  @override
  List<Object> get props => [size, sortedList];
}