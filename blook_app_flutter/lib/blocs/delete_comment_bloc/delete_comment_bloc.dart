import 'package:bloc/bloc.dart';
import 'package:blook_app_flutter/repository/comment_repository/comment_repository.dart';
import 'package:blook_app_flutter/utils/preferences.dart';
import 'package:equatable/equatable.dart';
import 'package:get_storage/get_storage.dart';

part 'delete_comment_event.dart';
part 'delete_comment_state.dart';

class DeleteCommentBloc extends Bloc<DeleteCommentEvent, DeleteCommentState> {
  final CommentRepository commentRepository;
  final box = GetStorage();
  
  DeleteCommentBloc(this.commentRepository) : super(DeleteCommentInitial()) {
    on<DeleteOneCommentEvent>(_deleteCommentEvent);
  }

  Future<void> _deleteCommentEvent(DeleteOneCommentEvent event, Emitter<DeleteCommentState> emit) async {
    try {
        commentRepository.deleteComment(event.id);
        final ex = await commentRepository.findCommentById(box.read("idbook"));
             box.write("exists", ex.commentexist);
      emit(DeleteSuccessState());
    } on Exception catch (e) {
      emit(DeleteErrorState(e.toString()));
    }
  }
}
