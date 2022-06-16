part of 'comments_bloc.dart';

abstract class CommentsState extends Equatable {
  const CommentsState();
  
  @override
  List<Object> get props => [];
}

class CommentsInitial extends CommentsState {}

class CommentsFetched extends CommentsState {
  final List<Comment> comments;
  final bool exists;
  const CommentsFetched(this.comments, this.exists);

  @override
  List<Object> get props => [comments, exists];
}

class CommentsFetchError extends CommentsState {
  final String message;
  const CommentsFetchError(this.message);

  @override
  List<Object> get props => [message];
}