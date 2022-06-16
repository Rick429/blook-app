
import 'package:blook_app_flutter/models/comment_exists_response.dart';
import 'package:blook_app_flutter/models/comment_response.dart';
import 'package:blook_app_flutter/models/create_comment_dto.dart';

abstract class CommentRepository {

  Future<Comment> createComment(CreateCommentDto createCommentDto, String idbook);
  
  Future<List<Comment>>fetchComments();

  Future<Comment> editComment(CreateCommentDto editCommentDto, String id);

  Future<void> deleteComment(String id);

  Future<CommentExistsResponse> findCommentById(String id);

}