part of 'delete_comment_bloc.dart';

abstract class DeleteCommentState extends Equatable {
  const DeleteCommentState();
  
  @override
  List<Object> get props => [];
}

class DeleteCommentInitial extends DeleteCommentState {}

class DeleteSuccessState extends DeleteCommentState {

  const DeleteSuccessState();

  @override
  List<Object> get props => [];
}

class DeleteErrorState extends DeleteCommentState {
  final String message;

  const DeleteErrorState(this.message);

  @override
  List<Object> get props => [message];
}