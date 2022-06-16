part of 'delete_comment_bloc.dart';

abstract class DeleteCommentEvent extends Equatable {
  const DeleteCommentEvent();

  @override
  List<Object> get props => [];
}
class DeleteOneCommentEvent extends DeleteCommentEvent {
  final String id;

  const DeleteOneCommentEvent(this.id);
}