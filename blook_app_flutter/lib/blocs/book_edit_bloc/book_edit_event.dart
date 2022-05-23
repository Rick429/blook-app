part of 'book_edit_bloc.dart';

abstract class BookEditEvent extends Equatable {
  const BookEditEvent();

  @override
  List<Object> get props => [];
}

class FetchOneEditBook extends BookEditEvent {
  
  const FetchOneEditBook();

  @override
  List<Object> get props => [];
}