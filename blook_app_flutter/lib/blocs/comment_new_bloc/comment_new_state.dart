part of 'comment_new_bloc.dart';

abstract class CommentNewState extends Equatable {
  const CommentNewState();
  
  @override
  List<Object> get props => [];
}

class CommentNewInitial extends CommentNewState {}

class CommentLoadingState extends CommentNewState {}

class CommentSuccessState extends CommentNewState {
  final Comment comment;
  final bool exists;
  const CommentSuccessState(this.comment, this.exists);

  @override
  List<Object> get props => [comment, exists];
}

class CommentErrorState extends CommentNewState {
  final ErrorResponse error;

  const CommentErrorState(this.error);

  @override
  List<Object> get props => [error];
}