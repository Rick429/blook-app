import 'package:bloc/bloc.dart';
import 'package:blook_app_flutter/models/comment_response.dart';
import 'package:blook_app_flutter/repository/comment_repository/comment_repository.dart';
import 'package:equatable/equatable.dart';

part 'comments_event.dart';
part 'comments_state.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  final CommentRepository commentRepository;

  CommentsBloc(this.commentRepository) : super(CommentsInitial()) {
    on<FetchAllComments>(_commentsFetched);
  }

  void _commentsFetched(FetchAllComments event, Emitter<CommentsState> emit) async {
    try {
      final mybooks = await commentRepository.fetchComments();
      emit(CommentsFetched(mybooks));
      return;
    } on Exception catch (e) {
      emit(CommentsFetchError(e.toString()));
    }
  }
}
