part of 'delete_book_bloc.dart';

abstract class DeleteBookEvent extends Equatable {
  const DeleteBookEvent();

  @override
  List<Object> get props => [];
}

class DeleteOneBookEvent extends DeleteBookEvent {
  final String id;

  const DeleteOneBookEvent(this.id);
}