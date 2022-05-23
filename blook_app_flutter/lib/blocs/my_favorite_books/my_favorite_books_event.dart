part of 'my_favorite_books_bloc.dart';

abstract class MyFavoriteBooksEvent extends Equatable {
  const MyFavoriteBooksEvent();

  @override
  List<Object> get props => [];
}

class FetchAllMyFavoriteBooks extends MyFavoriteBooksEvent {
  final int size;
  const FetchAllMyFavoriteBooks(this.size);

  @override
  List<Object> get props => [size];
}