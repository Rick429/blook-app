import 'package:bloc/bloc.dart';
import 'package:blook_app_flutter/models/book_response.dart';
import 'package:blook_app_flutter/models/search_dto.dart';
import 'package:blook_app_flutter/repository/book_repository/book_repository.dart';
import 'package:equatable/equatable.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final BookRepository bookRepository;
  
  SearchBloc(this.bookRepository) : super(SearchInitial()) {
    on<DoSearchEvent>(_doSearchEvent);
  }

  void _doSearchEvent(DoSearchEvent event, Emitter<SearchState> emit) async {
    try {
      final search = await bookRepository.findBook(event.searchDto);
      emit(SearchSuccessState(search));
      return;
    } on Exception catch (e) {
      emit(SearchErrorState(e.toString()));
    }
  }
}
