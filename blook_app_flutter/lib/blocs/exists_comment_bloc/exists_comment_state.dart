part of 'exists_comment_bloc.dart';

abstract class ExistsCommentState extends Equatable {
  const ExistsCommentState();
  
  @override
  List<Object> get props => [];
}

class ExistsCommentInitial extends ExistsCommentState {}

class ExistCommentFetched extends ExistsCommentState {
  final CommentExistsResponse commentExists;

  const ExistCommentFetched(this.commentExists);

  @override
  List<Object> get props => [commentExists];
}

class ExistCommentFetchError extends ExistsCommentState {
  final String message;
  const ExistCommentFetchError(this.message);

  @override
  List<Object> get props => [message];
}