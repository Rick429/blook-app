import 'package:bloc/bloc.dart';
import 'package:blook_app_flutter/models/book_response.dart';
import 'package:blook_app_flutter/repository/book_repository/book_repository.dart';
import 'package:equatable/equatable.dart';

part 'books_event.dart';
part 'books_state.dart';

class BooksBloc extends Bloc<BooksEvent, BooksState> {
  late BookRepository bookRepository;

  BooksBloc(this.bookRepository) : super(BooksInitial()) {
    on<FetchBooksWithType>(_booksFetched);
  }

  void _booksFetched(FetchBooksWithType event, Emitter<BooksState> emit) async {
    try {
      final books = await bookRepository.fetchBooks(event.type);
      emit(BooksFetched(books, event.type));
      return;
    } on Exception catch (e) {
      emit(BooksFetchError(e.toString()));
    }
  }
}
