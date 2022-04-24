part of 'comments_bloc.dart';

abstract class CommentsEvent extends Equatable {
  const CommentsEvent();

  @override
  List<Object> get props => [];
}

class FetchAllComments extends CommentsEvent {

  const FetchAllComments();

  @override
  List<Object> get props => [];
}