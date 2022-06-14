import 'package:bloc/bloc.dart';
import 'package:blook_app_flutter/models/book_response.dart';
import 'package:blook_app_flutter/repository/book_repository/book_repository.dart';
import 'package:blook_app_flutter/utils/preferences.dart';
import 'package:equatable/equatable.dart';
import 'package:get_storage/get_storage.dart';

part 'book_favorite_event.dart';
part 'book_favorite_state.dart';

class BookFavoriteBloc extends Bloc<BookFavoriteEvent, BookFavoriteState> {
  final BookRepository bookRepository;
  final box = GetStorage();
  
  BookFavoriteBloc(this.bookRepository) : super(BookFavoriteInitial()) {
    on<AddBookFavorite>(_AddBookFavorite);
  }

  void _AddBookFavorite(AddBookFavorite event, Emitter<BookFavoriteState> emit) async {
    try {
      final book = await bookRepository.addFavoriteBook(box.read("idbook"));
      emit(BookFavorite(book));
      return;
    } on Exception catch (e) {
      emit(BookFavoriteError(e.toString()));
    }
  }
}
