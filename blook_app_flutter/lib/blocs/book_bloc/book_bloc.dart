import 'package:bloc/bloc.dart';
import 'package:blook_app_flutter/models/book_response.dart';
import 'package:blook_app_flutter/models/favorite_response.dart';
import 'package:blook_app_flutter/repository/book_repository/book_repository.dart';
import 'package:blook_app_flutter/repository/comment_repository/comment_repository.dart';
import 'package:blook_app_flutter/utils/preferences.dart';
import 'package:equatable/equatable.dart';

part 'book_event.dart';
part 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  final BookRepository bookRepository;
  final CommentRepository commentRepository;

  BookBloc(this.bookRepository, this.commentRepository) : super(BookInitial()) {
    on<FetchOneBook>(_BookFetched);
  }

  void _BookFetched(FetchOneBook event, Emitter<BookState> emit) async {
    try {
      final book = await bookRepository.findBookById(PreferenceUtils.getString("idbook")!);
      final favorite = await bookRepository.isFavorite(PreferenceUtils.getString("idbook")!);
/*       final ex = await commentRepository.findCommentById(PreferenceUtils.getString("idbook")!);
      PreferenceUtils.setBool("exists", ex.commentexist); */
      emit(OneBookFetched(book, favorite));
      return;
    } on Exception catch (e) {
      emit(OneBookFetchError(e.toString()));
    }
  }
}
