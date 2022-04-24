part of 'my_favorite_books_bloc.dart';

abstract class MyFavoriteBooksEvent extends Equatable {
  const MyFavoriteBooksEvent();

  @override
  List<Object> get props => [];
}

class FetchAllMyFavoriteBooks extends MyFavoriteBooksEvent {

  const FetchAllMyFavoriteBooks();

  @override
  List<Object> get props => [];
}