import 'package:bloc/bloc.dart';
import 'package:blook_app_flutter/models/comment_response.dart';
import 'package:blook_app_flutter/models/create_comment_dto.dart';
import 'package:blook_app_flutter/repository/comment_repository/comment_repository.dart';
import 'package:equatable/equatable.dart';

part 'edit_comment_event.dart';
part 'edit_comment_state.dart';

class EditCommentBloc extends Bloc<EditCommentEvent, EditCommentState> {
  final CommentRepository commentRepository;
  EditCommentBloc(this.commentRepository) : super(EditCommentInitial()) {
    on<EditOneCommentEvent>(_editComment);
  }
  void _editComment(EditOneCommentEvent event, Emitter<EditCommentState> emit) async {
    try {
      final comment = await commentRepository.editComment(
          event.editCommentDto, event.id);

      emit(EditCommentSuccessState(comment));
    } catch (e) {
      emit(const EditCommentErrorState('Error al editar el comentario'));
    }
  }
}
