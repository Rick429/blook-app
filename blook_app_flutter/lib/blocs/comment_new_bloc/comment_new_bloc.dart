import 'package:bloc/bloc.dart';
import 'package:blook_app_flutter/models/book_response.dart';
import 'package:blook_app_flutter/models/create_comment_dto.dart';
import 'package:blook_app_flutter/repository/comment_repository/comment_repository.dart';
import 'package:equatable/equatable.dart';

part 'comment_new_event.dart';
part 'comment_new_state.dart';

class CommentNewBloc extends Bloc<CommentNewEvent, CommentNewState> {
  final CommentRepository commentRepository;

  CommentNewBloc(this.commentRepository) : super(CommentNewInitial()) {
    on<createCommentEvent>(_createCommentEvent);
  }

  void _createCommentEvent(createCommentEvent event, Emitter<CommentNewState> emit) async {
    try {
      final comment = await commentRepository.createComment(event.createCommentDto, event.idbook);
      emit(CommentSuccessState(comment));
      return;
    } on Exception catch (e) {
      emit(CommentErrorState(e.toString()));
    }
  }
}
