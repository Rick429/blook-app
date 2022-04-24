import 'package:blook_app_flutter/models/book_response.dart';
import 'package:blook_app_flutter/models/create_comment_dto.dart';

abstract class CommentRepository {

  Future<Comment> createComment(CreateCommentDto createCommentDto, String idbook);
  
}