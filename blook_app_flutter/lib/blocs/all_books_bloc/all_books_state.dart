part of 'all_books_bloc.dart';

abstract class AllBooksState extends Equatable {
  const AllBooksState();
  
  @override
  List<Object> get props => [];
}

class AllBooksInitial extends AllBooksState {}

class AllBooksFetched extends AllBooksState {
  final List<Book> allbooks;
  final int pagesize; 

  const AllBooksFetched(this.allbooks, this.pagesize);

  @override
  List<Object> get props => [allbooks];
}

class AllBooksFetchError extends AllBooksState {
  final String message;
  const AllBooksFetchError(this.message);

  @override
  List<Object> get props => [message];
}