part of 'genres_bloc.dart';

abstract class GenresState extends Equatable {
  const GenresState();
  
  @override
  List<Object> get props => [];
}

class GenresInitial extends GenresState {}

class GenresFetched extends GenresState {
  final List<Genre> genres;

  const GenresFetched(this.genres);

  @override
  List<Object> get props => [genres];
}

class GenresFetchError extends GenresState {
  final String message;
  const GenresFetchError(this.message);

  @override
  List<Object> get props => [message];
}