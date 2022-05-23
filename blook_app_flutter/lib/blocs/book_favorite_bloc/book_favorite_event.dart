part of 'book_favorite_bloc.dart';

abstract class BookFavoriteEvent extends Equatable {
  const BookFavoriteEvent();

  @override
  List<Object> get props => [];
}

class AddBookFavorite extends BookFavoriteEvent {

  const AddBookFavorite();

  @override
  List<Object> get props => [];
}