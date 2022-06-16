part of 'book_favorite_bloc.dart';

abstract class BookFavoriteState extends Equatable {
  const BookFavoriteState();
  
  @override
  List<Object> get props => [];
}

class BookFavoriteInitial extends BookFavoriteState {}

class BookFavorite extends BookFavoriteState {
  final Book book;

  const BookFavorite(this.book);

  @override
  List<Object> get props => [book];
}

class BookFavoriteError extends BookFavoriteState {
  final String message;
  const BookFavoriteError(this.message);

  @override
  List<Object> get props => [message];
}