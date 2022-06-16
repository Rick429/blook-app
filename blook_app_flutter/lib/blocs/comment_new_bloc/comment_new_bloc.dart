import 'package:bloc/bloc.dart';
import 'package:blook_app_flutter/models/comment_response.dart';
import 'package:blook_app_flutter/models/create_comment_dto.dart';
import 'package:blook_app_flutter/repository/comment_repository/comment_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:get_storage/get_storage.dart';
import '../../models/error_response.dart';
import '../../utils/preferences.dart';
part 'comment_new_event.dart';
part 'comment_new_state.dart';

class CommentNewBloc extends Bloc<CommentNewEvent, CommentNewState> {
  final CommentRepository commentRepository;
  final box = GetStorage();

  CommentNewBloc(this.commentRepository) : super(CommentNewInitial()) {
    on<createCommentEvent>(_createCommentEvent);
  }

  void _createCommentEvent(createCommentEvent event, Emitter<CommentNewState> emit) async {
    try {
      final ex = await commentRepository.findCommentById(event.idbook);

      final comment;
      if(ex.commentexist){
 comment = await commentRepository.editComment(
          event.createCommentDto, event.idbook);
     

      }
    
      else {
          comment = await commentRepository.createComment(event.createCommentDto, event.idbook);

 
      }
      final ex2 = await commentRepository.findCommentById(event.idbook);
    box.write("exists", ex2.commentexist);
      emit(CommentSuccessState(comment, ex2.commentexist));
      return;
    } on ErrorResponse catch (e) {
      emit(CommentErrorState(e));
    }
  }
}
