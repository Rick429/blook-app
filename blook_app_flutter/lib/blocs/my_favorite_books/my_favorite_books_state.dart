part of 'my_favorite_books_bloc.dart';

abstract class MyFavoriteBooksState extends Equatable {
  const MyFavoriteBooksState();
  
  @override
  List<Object> get props => [];
}

class MyFavoriteBooksInitial extends MyFavoriteBooksState {}

class MyFavoriteBooksFetched extends MyFavoriteBooksState {
  final List<Book> mybooks;
  final int pagesize; 

  const MyFavoriteBooksFetched(this.mybooks, this.pagesize);

  @override
  List<Object> get props => [mybooks, pagesize];
}

class MyFavoriteBooksFetchError extends MyFavoriteBooksState {
  final String message;
  const MyFavoriteBooksFetchError(this.message);

  @override
  List<Object> get props => [message];
}