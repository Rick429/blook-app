part of 'all_books_bloc.dart';

abstract class AllBooksEvent extends Equatable {
  const AllBooksEvent();

  @override
  List<Object> get props => [];
}

class FetchAllBooks extends AllBooksEvent {
  final int size;
  final String sortedList;
  const FetchAllBooks(this.size, this.sortedList);

  @override
  List<Object> get props => [size, sortedList];
}