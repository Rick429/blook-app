import 'package:bloc/bloc.dart';
import 'package:blook_app_flutter/repository/book_repository/book_repository.dart';
import 'package:equatable/equatable.dart';

part 'delete_book_event.dart';
part 'delete_book_state.dart';

class DeleteBookBloc extends Bloc<DeleteBookEvent, DeleteBookState> {
  final BookRepository bookRepository;

  DeleteBookBloc(this.bookRepository) : super(DeleteBookInitial()) {
    on<DeleteOneBookEvent>(_deleteBookEvent);
  }

  void _deleteBookEvent(DeleteOneBookEvent event, Emitter<DeleteBookState> emit) {
    try {
        bookRepository.deleteBook(event.id);
      emit(DeleteSuccessState());
    } on Exception catch (e) {
      emit(DeleteErrorState(e.toString()));
    }
  }
}
