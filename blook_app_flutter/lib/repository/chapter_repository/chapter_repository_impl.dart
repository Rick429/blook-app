import 'dart:convert';
import 'package:blook_app_flutter/constants.dart';
import 'package:blook_app_flutter/models/book_response.dart';
import 'package:blook_app_flutter/models/chapter_dto.dart';
import 'package:blook_app_flutter/models/create_chapter_dto.dart';
import 'package:blook_app_flutter/models/error_response.dart';
import 'package:blook_app_flutter/repository/chapter_repository/chapter_repository.dart';
import 'package:blook_app_flutter/utils/preferences.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
class ChapterRepositoryImpl extends ChapterRepository {
  final Client _client = Client();

  @override
  Future<Chapter> createChapter(CreateChapterDto createChapterDto, String filename, String idbook) async{
 var request = http.MultipartRequest(
      'POST', Uri.parse('${Constant.baseurl}chapter/${idbook}'),);

      request.files.add(http.MultipartFile.fromString('chapter', jsonEncode(createChapterDto.toJson()),
        contentType: MediaType('application', 'json'), filename: "chapter",
        )
        );
    
      request.files.add(await http.MultipartFile.fromPath('file',filename));
    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer ${PreferenceUtils.getString('token')}' 
     
    };
     request.headers.addAll(headers);
    var res = await request.send();
    final respStr = await res.stream.bytesToString();
    if (res.statusCode == 201) {
      Chapter chapterNew = Chapter.fromJson(json.decode(respStr));
      return chapterNew;
    } else {
      final error = ErrorResponse.fromJson(json.decode(respStr));
      throw Exception(error.mensaje);
    }
  }

  @override
  void deleteChapter(String id){
     _client.delete(Uri.parse('${Constant.baseurl}chapter/$id'), headers: {
     'Authorization': 'Bearer ${PreferenceUtils.getString(Constant.token)}'
    });
  }

}