import 'package:bloc/bloc.dart';
import 'package:blook_app_flutter/utils/preferences.dart';
import 'package:equatable/equatable.dart';

import '../../models/comment_exists_response.dart';
import '../../repository/comment_repository/comment_repository.dart';

part 'exists_comment_event.dart';
part 'exists_comment_state.dart';

class ExistsCommentBloc extends Bloc<ExistsCommentEvent, ExistsCommentState> {
  final CommentRepository commentRepository;
  ExistsCommentBloc(this.commentRepository) : super(ExistsCommentInitial()) {
    on<FetchExistsComment>(_existsComment);
    
  }
   
  void _existsComment(FetchExistsComment event, Emitter<ExistsCommentState> emit) async {
    try {
        final ex = await commentRepository.findCommentById(PreferenceUtils.getString("idBook")!);
      emit(ExistCommentFetched(ex));
      return;
    } on Exception catch (e) {
      emit(ExistCommentFetchError(e.toString()));
    }
  }

      
}
