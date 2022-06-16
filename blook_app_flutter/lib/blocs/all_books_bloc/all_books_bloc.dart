import 'package:bloc/bloc.dart';
import 'package:blook_app_flutter/repository/book_repository/book_repository.dart';
import 'package:equatable/equatable.dart';

import '../../models/book_response.dart';

part 'all_books_event.dart';
part 'all_books_state.dart';

class AllBooksBloc extends Bloc<AllBooksEvent, AllBooksState> {
  final BookRepository bookRepository;

  AllBooksBloc(this.bookRepository) : super(AllBooksInitial()) {
    on<FetchAllBooks>(_allbooksFetched);
  }

   void _allbooksFetched(FetchAllBooks event, Emitter<AllBooksState> emit) async {
    try {
      final allbooks = await bookRepository.fetchAllBooks(event.size, event.sortedList);
      emit(AllBooksFetched(allbooks.content, allbooks.totalElements));
      return;
    } on Exception catch (e) {
      emit(AllBooksFetchError(e.toString()));
    }
  }
}
