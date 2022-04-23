import 'package:bloc/bloc.dart';
import 'package:blook_app_flutter/models/book_response.dart';
import 'package:blook_app_flutter/repository/book_repository/book_repository.dart';
import 'package:blook_app_flutter/utils/preferences.dart';
import 'package:equatable/equatable.dart';

part 'book_event.dart';
part 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  final BookRepository bookRepository;

  BookBloc(this.bookRepository) : super(BookInitial()) {
    on<FetchOneBook>(_BookFetched);
  }

  void _BookFetched(FetchOneBook event, Emitter<BookState> emit) async {
    try {
      final book = await bookRepository.findBookById(PreferenceUtils.getString("id")!);
      emit(OneBookFetched(book));
      return;
    } on Exception catch (e) {
      emit(OneBookFetchError(e.toString()));
    }
  }
}
