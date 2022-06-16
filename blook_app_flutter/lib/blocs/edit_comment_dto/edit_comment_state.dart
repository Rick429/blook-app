part of 'edit_comment_bloc.dart';

abstract class EditCommentState extends Equatable {
  const EditCommentState();
  
  @override
  List<Object> get props => [];
}

class EditCommentInitial extends EditCommentState {}

class EditCommentSuccessState extends EditCommentState {
  final Comment comment;

  const EditCommentSuccessState(this.comment);

  @override
  List<Object> get props => [comment];
}

class EditCommentErrorState extends EditCommentState {
  final String message;

  const EditCommentErrorState(this.message);

  @override
  List<Object> get props => [message];
}