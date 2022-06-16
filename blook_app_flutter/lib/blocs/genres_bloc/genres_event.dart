part of 'genres_bloc.dart';

abstract class GenresEvent extends Equatable{
  const GenresEvent();

  @override
  List<Object> get props => [];
  
}

class FetchAllGenres extends GenresEvent {

  const FetchAllGenres();

  @override
  List<Object> get props => [];
}