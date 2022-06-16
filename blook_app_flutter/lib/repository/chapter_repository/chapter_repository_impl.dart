import 'dart:convert';
import 'package:blook_app_flutter/constants.dart';
import 'package:blook_app_flutter/models/book_response.dart';
import 'package:blook_app_flutter/models/create_chapter_dto.dart';
import 'package:blook_app_flutter/models/error_response.dart';
import 'package:blook_app_flutter/repository/chapter_repository/chapter_repository.dart';
import 'package:blook_app_flutter/utils/preferences.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
class ChapterRepositoryImpl extends ChapterRepository {
  final Client _client = Client();
  final box = GetStorage();
  
  @override
  Future<Chapter> createChapter(CreateChapterDto createChapterDto, String filename, String idbook) async{
 var request = http.MultipartRequest(
      'POST', Uri.parse('${Constant.baseurl}chapter/$idbook'),);

      request.files.add(http.MultipartFile.fromString('chapter', jsonEncode(createChapterDto.toJson()),
        contentType: MediaType('application', 'json'), filename: "chapter",
        )
        );
    
      request.files.add(await http.MultipartFile.fromPath('file',filename));
    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer ${box.read('token')}' 
     
    };
     request.headers.addAll(headers);
    var res = await request.send();
    final respStr = await res.stream.bytesToString();
    if (res.statusCode == 201) {
      Chapter chapterNew = Chapter.fromJson(json.decode(respStr));
      return chapterNew;
    } else {
      final error = ErrorResponse.fromJson(json.decode(respStr));
      throw error;
    }
  }

  @override
  void deleteChapter(String id){
     _client.delete(Uri.parse('${Constant.baseurl}chapter/$id'), headers: {
     'Authorization': 'Bearer ${box.read(Constant.token)}'
    });
  }

  @override
  Future<Chapter> editChapter(CreateChapterDto editChapterDto, String id) async {
     var request = http.MultipartRequest(
      'PUT', Uri.parse('${Constant.baseurl}chapter/$id'),);

      request.files.add(http.MultipartFile.fromString('chapter', jsonEncode(editChapterDto.toJson()),
        contentType: MediaType('application', 'json'), filename: "chapter",
        )
        );
  
    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer ${box.read('token')}' 
    };
     request.headers.addAll(headers);
    var res = await request.send();
    final respStr = await res.stream.bytesToString();
    if (res.statusCode == 200) {
      Chapter editChapter = Chapter.fromJson(json.decode(respStr));
      return editChapter;
    } else {
      final error = ErrorResponse.fromJson(json.decode(respStr));
      throw error;
    }
  }

  @override
  Future<Chapter> editChapterFile(String filename, String id) async {
     var request = http.MultipartRequest(
      'PUT', Uri.parse('${Constant.baseurl}chapter/file/$id'),);

    request.files.add(await http.MultipartFile.fromPath('file',filename));
   
    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer ${box.read('token')}' 
    };
     request.headers.addAll(headers);
    var res = await request.send();
    final respStr = await res.stream.bytesToString();
    if (res.statusCode == 200) {
      Chapter editChapter = Chapter.fromJson(json.decode(respStr));
      return editChapter;
    } else {
      final error = ErrorResponse.fromJson(json.decode(respStr));
      throw Exception(error.mensaje);
    }
  }
}