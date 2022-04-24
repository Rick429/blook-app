part of 'my_favorite_books_bloc.dart';

abstract class MyFavoriteBooksState extends Equatable {
  const MyFavoriteBooksState();
  
  @override
  List<Object> get props => [];
}

class MyFavoriteBooksInitial extends MyFavoriteBooksState {}

class MyFavoriteBooksFetched extends MyFavoriteBooksState {
  final List<Book> mybooks;

  const MyFavoriteBooksFetched(this.mybooks);

  @override
  List<Object> get props => [mybooks];
}

class MyFavoriteBooksFetchError extends MyFavoriteBooksState {
  final String message;
  const MyFavoriteBooksFetchError(this.message);

  @override
  List<Object> get props => [message];
}