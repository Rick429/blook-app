import 'dart:convert';
import 'package:blook_app_flutter/constants.dart';
import 'package:blook_app_flutter/models/book_response.dart';
import 'package:blook_app_flutter/models/create_comment_dto.dart';
import 'package:blook_app_flutter/models/error_response.dart';
import 'package:blook_app_flutter/repository/comment_repository/comment_repository.dart';
import 'package:blook_app_flutter/utils/preferences.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class CommentRepositoryImpl extends CommentRepository {
  final Client _client = Client();

  @override
  createComment(CreateCommentDto createCommentDto, String idbook) async{
      var request = http.MultipartRequest(
      'POST', Uri.parse('${Constant.baseurl}comment/${idbook}'),);

      request.files.add(http.MultipartFile.fromString('comment', jsonEncode(createCommentDto.toJson()),
        contentType: MediaType('application', 'json'), filename: "comment",
        )
        );
    
   
    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer ${PreferenceUtils.getString('token')}' 
     
    };
     request.headers.addAll(headers);
    var res = await request.send();
    final respStr = await res.stream.bytesToString();
    if (res.statusCode == 201) {
      Comment commentNew = Comment.fromJson(json.decode(respStr));
      return commentNew;
    } else {
      final error = ErrorResponse.fromJson(json.decode(respStr));
      throw Exception(error.mensaje);
    }
  }
}