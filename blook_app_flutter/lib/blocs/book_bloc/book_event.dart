part of 'book_bloc.dart';

abstract class BookEvent extends Equatable {
  const BookEvent();

  @override
  List<Object> get props => [];
}

class FetchOneBook extends BookEvent {
  
  const FetchOneBook();

  @override
  List<Object> get props => [];
}