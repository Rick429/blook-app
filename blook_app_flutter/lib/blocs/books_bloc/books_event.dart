part of 'books_bloc.dart';

abstract class BooksEvent extends Equatable {
  const BooksEvent();

  @override
  List<Object> get props => [];
}

class FetchBooksWithType extends BooksEvent {
  final String type;

  const FetchBooksWithType(this.type);

  @override
  List<Object> get props => [type];
}