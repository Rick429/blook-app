part of 'book_new_bloc.dart';

abstract class BookNewEvent extends Equatable{
  const BookNewEvent();

  @override
  List<Object> get props => [];
}

class CreateBookEvent extends BookNewEvent {
  final String source;
  final CreateBookDto createBookDto;

  const CreateBookEvent(this.source, this.createBookDto);

  @override
  List<Object> get props => [source, createBookDto];
}