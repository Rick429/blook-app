import 'package:bloc/bloc.dart';
import 'package:blook_app_flutter/repository/comment_repository/comment_repository.dart';
import 'package:equatable/equatable.dart';

part 'delete_comment_event.dart';
part 'delete_comment_state.dart';

class DeleteCommentBloc extends Bloc<DeleteCommentEvent, DeleteCommentState> {
  final CommentRepository commentRepository;
  DeleteCommentBloc(this.commentRepository) : super(DeleteCommentInitial()) {
    on<DeleteOneCommentEvent>(_deleteCommentEvent);
  }

  void _deleteCommentEvent(DeleteOneCommentEvent event, Emitter<DeleteCommentState> emit) {
    try {
        commentRepository.deleteComment(event.id);
      emit(DeleteSuccessState());
    } on Exception catch (e) {
      emit(DeleteErrorState(e.toString()));
    }
  }
}
