part of 'edit_book_bloc.dart';

abstract class EditBookEvent extends Equatable {
  const EditBookEvent();

  @override
  List<Object> get props => [];
}

class  EditOneBookEvent extends EditBookEvent {
  final String source;
  final CreateBookDto editBookDto;
  final String id;

  const EditOneBookEvent(this.source, this.editBookDto, this.id);

  @override
  List<Object> get props => [source, editBookDto];
}