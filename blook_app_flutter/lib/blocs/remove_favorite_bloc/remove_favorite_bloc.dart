import 'package:bloc/bloc.dart';
import 'package:blook_app_flutter/repository/book_repository/book_repository.dart';
import 'package:equatable/equatable.dart';

part 'remove_favorite_event.dart';
part 'remove_favorite_state.dart';

class RemoveFavoriteBloc extends Bloc<RemoveFavoriteEvent, RemoveFavoriteState> {
  final BookRepository bookRepository;
  
  RemoveFavoriteBloc(this.bookRepository) : super(RemoveFavoriteInitial()) {
    on<RemoveFavoriteBookEvent>(_removeFavoriteBookEvent);
  }

  void _removeFavoriteBookEvent(RemoveFavoriteBookEvent event, Emitter<RemoveFavoriteState> emit) {
    try {
        bookRepository.removeFavorite(event.id);
      emit(RemoveSuccessState());
    } on Exception catch (e) {
      emit(RemoveErrorState(e.toString()));
    }
  }
}
