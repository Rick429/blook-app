import 'package:bloc/bloc.dart';
import 'package:blook_app_flutter/models/book_response.dart';
import 'package:blook_app_flutter/repository/book_repository/book_repository.dart';
import 'package:equatable/equatable.dart';

part 'my_books_event.dart';
part 'my_books_state.dart';

class MyBooksBloc extends Bloc<MyBooksEvent, MyBooksState> {
  final BookRepository bookRepository;

  MyBooksBloc(this.bookRepository) : super(MyBooksInitial()) {
    on<FetchAllMyBooks>(_mybooksFetched);
  }

   void _mybooksFetched(FetchAllMyBooks event, Emitter<MyBooksState> emit) async {
    try {
      final mybooks = await bookRepository.fetchMyBooks(event.size);
      emit(MyBooksFetched(mybooks.content, mybooks.totalElements));
      return;
    } on Exception catch (e) {
      emit(MyBooksFetchError(e.toString()));
    }
  }
}
