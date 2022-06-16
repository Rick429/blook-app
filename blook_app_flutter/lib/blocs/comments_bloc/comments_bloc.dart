import 'package:bloc/bloc.dart';
import 'package:blook_app_flutter/models/comment_exists_response.dart';
import 'package:blook_app_flutter/models/comment_response.dart';
import 'package:blook_app_flutter/repository/comment_repository/comment_repository.dart';
import 'package:blook_app_flutter/utils/preferences.dart';
import 'package:equatable/equatable.dart';
import 'package:get_storage/get_storage.dart';

part 'comments_event.dart';
part 'comments_state.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  final CommentRepository commentRepository;
  final box = GetStorage();
  
  CommentsBloc(this.commentRepository) : super(CommentsInitial()) {
    on<FetchAllComments>(_commentsFetched);
  }

  void _commentsFetched(FetchAllComments event, Emitter<CommentsState> emit) async {
    try {
     final ex = await commentRepository.findCommentById(box.read("idbook")!);
             box.write("exists", ex.commentexist);
      final comments = await commentRepository.fetchComments();
       
      emit(CommentsFetched(comments, ex.commentexist));
      return;
    } on Exception catch (e) {
      emit(CommentsFetchError(e.toString()));
    }
  }
}
