import 'package:bloc/bloc.dart';
import 'package:blook_app_flutter/models/book_response.dart';
import 'package:blook_app_flutter/repository/book_repository/book_repository.dart';
import 'package:equatable/equatable.dart';

part 'my_favorite_books_event.dart';
part 'my_favorite_books_state.dart';

class MyFavoriteBooksBloc extends Bloc<MyFavoriteBooksEvent, MyFavoriteBooksState> {
  final BookRepository bookRepository;
  
  MyFavoriteBooksBloc(this.bookRepository) : super(MyFavoriteBooksInitial()) {
    on<FetchAllMyFavoriteBooks>(_myFavoritBooksFetched);
  }

  void _myFavoritBooksFetched(FetchAllMyFavoriteBooks event, Emitter<MyFavoriteBooksState> emit) async {
    try {
      final mybooks = await bookRepository.fetchMyFavoriteBooks(event.size);
      emit(MyFavoriteBooksFetched(mybooks.content, mybooks.totalElements));
      return;
    } on Exception catch (e) {
      emit(MyFavoriteBooksFetchError(e.toString()));
    }
  }
}
