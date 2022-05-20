part of 'edit_comment_bloc.dart';

abstract class EditCommentEvent extends Equatable {
  const EditCommentEvent();

  @override
  List<Object> get props => [];
}
class  EditOneCommentEvent extends EditCommentEvent {
  final CreateCommentDto editCommentDto;
  final String id;

  const EditOneCommentEvent(this.editCommentDto, this.id);

  @override
  List<Object> get props => [editCommentDto, id];
}