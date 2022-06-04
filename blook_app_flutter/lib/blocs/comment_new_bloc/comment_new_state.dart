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

  const CommentSuccessState(this.comment);

  @override
  List<Object> get props => [comment];
}

class CommentErrorState extends CommentNewState {
  final ErrorResponse error;

  const CommentErrorState(this.error);

  @override
  List<Object> get props => [error];
}