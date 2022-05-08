import 'package:bloc/bloc.dart';
import 'package:blook_app_flutter/models/book_response.dart';
import 'package:blook_app_flutter/models/genre_response.dart';
import 'package:blook_app_flutter/repository/book_repository/book_repository.dart';
import 'package:blook_app_flutter/repository/genre_repository/genre_repository.dart';
import 'package:blook_app_flutter/utils/preferences.dart';
import 'package:equatable/equatable.dart';

part 'book_edit_event.dart';
part 'book_edit_state.dart';

class BookEditBloc extends Bloc<BookEditEvent, BookEditState> {
  final BookRepository bookRepository;
  final GenreRepository genreRepository;
  BookEditBloc(this.bookRepository, this.genreRepository) : super(BookEditInitial()) {
  
    on<FetchOneEditBook>(_BookEditFetched);
  }

  void _BookEditFetched(FetchOneEditBook event, Emitter<BookEditState> emit) async {
    try {
      final book = await bookRepository.findBookById(PreferenceUtils.getString("idbook")!);
      final generos = await genreRepository.fetchAllGenres();
      emit(OneBookEditFetched(book, generos, book.genres));
      return;
    } on Exception catch (e) {
      emit(OneBookEditFetchError(e.toString()));
    }
  }
}
