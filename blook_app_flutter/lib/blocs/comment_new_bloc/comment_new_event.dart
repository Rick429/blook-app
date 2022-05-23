part of 'comment_new_bloc.dart';

abstract class CommentNewEvent extends Equatable {
  const CommentNewEvent();

  @override
  List<Object> get props => [];
}

class createCommentEvent extends CommentNewEvent {
  final CreateCommentDto createCommentDto;
  final String idbook;

  const createCommentEvent(this.createCommentDto, this.idbook);
}