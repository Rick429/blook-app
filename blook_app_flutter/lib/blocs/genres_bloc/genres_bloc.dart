import 'package:bloc/bloc.dart';
import 'package:blook_app_flutter/models/genre_response.dart';
import 'package:blook_app_flutter/repository/genre_repository/genre_repository.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'genres_event.dart';
part 'genres_state.dart';

class GenresBloc extends Bloc<GenresEvent, GenresState> {
  final GenreRepository genreRepository;
  GenresBloc(this.genreRepository) : super(GenresInitial()) {
    on<FetchAllGenres>(_genresFetched);
  }

  void _genresFetched(FetchAllGenres event, Emitter<GenresState> emit) async {
    try {
      final genres = await genreRepository.fetchAllGenres();
      emit(GenresFetched(genres));
      return;
    } on Exception catch (e) {
      emit(GenresFetchError(e.toString()));
    }
  }
}
