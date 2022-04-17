import 'dart:convert';
import 'package:blook_app_flutter/constants.dart';
import 'package:blook_app_flutter/models/book_dto.dart';
import 'package:blook_app_flutter/models/create_book_dto.dart';
import 'package:blook_app_flutter/models/error_response.dart';
import 'package:blook_app_flutter/models/user_dto.dart';
import 'package:blook_app_flutter/repository/book_repository/book_repository.dart';
import 'package:blook_app_flutter/utils/preferences.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
class BookRepositoryImpl extends BookRepository {
  final Client _client = Client();

  @override
  Future<Book> createBook(CreateBookDto createBookDto, String filename) async{
 var request = http.MultipartRequest(
      'POST', Uri.parse('${Constant.baseurl}book/'),);

      request.files.add(http.MultipartFile.fromString('book', jsonEncode(createBookDto.toJson()),
        contentType: MediaType('application', 'json'), filename: "book",
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
      Book bookNew = Book.fromJson(json.decode(respStr));
      return bookNew;
    } else {
      final error = ErrorResponse.fromJson(json.decode(respStr));
      throw Exception(error.mensaje);
    }
  }
}