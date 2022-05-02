import 'dart:convert';
import 'package:blook_app_flutter/constants.dart';
import 'package:blook_app_flutter/models/book_response.dart';
import 'package:blook_app_flutter/models/create_book_dto.dart';
import 'package:blook_app_flutter/models/error_response.dart';
import 'package:blook_app_flutter/models/favorite_response.dart';
import 'package:blook_app_flutter/models/search_dto.dart';
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

  @override
  Future <BookResponse> fetchMyBooks(int size, String sortedList) async{
     final response = await _client.get(Uri.
     parse('${Constant.baseurl}book/all/user/${PreferenceUtils.getString("nick")}?size=$size&sort=$sortedList'),
      headers: {
     'Content-Type': 'application/json',
     'Accept': 'application/json',
     'Authorization': 'Bearer ${PreferenceUtils.getString(Constant.token)}'
    });
    if (response.statusCode == 200) {
      return BookResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Fail to load books');
    }
  }

  @override
  Future<Book>findBookById(String id) async{
     final response = await _client.get(Uri.parse('${Constant.baseurl}book/${id}'), headers: {
     'Content-Type': 'application/json',
     'Accept': 'application/json',
     'Authorization': 'Bearer ${PreferenceUtils.getString(Constant.token)}'
    });
    if (response.statusCode == 200) {
      return Book.fromJson(json.decode(response.body));
    } else {
      throw Exception('Fail to load book');
    }
  }

  @override
  Future<Book>addFavoriteBook(String id) async{
     final response = await _client.post(Uri.parse('${Constant.baseurl}book/favorite/${id}'), headers: {
     'Content-Type': 'application/json',
     'Accept': 'application/json',
     'Authorization': 'Bearer ${PreferenceUtils.getString(Constant.token)}'
    });
    if (response.statusCode == 201) {
      return Book.fromJson(json.decode(response.body));
    } else {
      throw Exception('Fail to load book');
    }
  }

  @override
  Future<BookResponse>fetchMyFavoriteBooks(int size) async{
     final response = await _client.get(Uri.parse('${Constant.baseurl}book/all/favorite/${PreferenceUtils.getString("nick")}?size=$size'), headers: {
     'Content-Type': 'application/json',
     'Accept': 'application/json',
     'Authorization': 'Bearer ${PreferenceUtils.getString(Constant.token)}'
    });
    if (response.statusCode == 200) {
      return BookResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Fail to load books');
    }
  }

  @override
  Future<List<Book>>fetchBooks(String type) async{
     final response = await _client.get(Uri.parse('${Constant.baseurl}book/all/$type'), headers: {
     'Content-Type': 'application/json',
     'Accept': 'application/json',
     'Authorization': 'Bearer ${PreferenceUtils.getString(Constant.token)}'
    });
    if (response.statusCode == 200) {
      return BookResponse.fromJson(json.decode(response.body)).content;
    } else {
      throw Exception('Fail to load books');
    }
  }

  @override
  Future<List<Book>> findBook(SearchDto searchDto) async {
   var request = http.MultipartRequest('POST', Uri.parse('${Constant.baseurl}book/search/all'),);

      request.files.add(http.MultipartFile.fromString('search', jsonEncode(searchDto.toJson()),
        contentType: MediaType('application', 'json'), filename: "search",
        ),
      );
    
    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer ${PreferenceUtils.getString('token')}' 
     
    };
     request.headers.addAll(headers);
    var res = await request.send();
    final respStr = await res.stream.bytesToString();
    if (res.statusCode == 200) {
      BookResponse books = BookResponse.fromJson(json.decode(respStr));
      return books.content;
    } else {
      final error = ErrorResponse.fromJson(json.decode(respStr));
      throw Exception(error.mensaje);
    }
  }

  @override
  void deleteBook(String id){
     _client.delete(Uri.parse('${Constant.baseurl}book/$id'), headers: {
     'Authorization': 'Bearer ${PreferenceUtils.getString(Constant.token)}'
    });
  }

   @override
  void removeFavorite(String id){
     _client.delete(Uri.parse('${Constant.baseurl}book/favorite/remove/$id'), headers: {
     'Authorization': 'Bearer ${PreferenceUtils.getString(Constant.token)}'
    });
  }

  @override
  Future<FavoriteResponse> isFavorite(String id) async{
     final response = await _client.get(Uri.parse('${Constant.baseurl}book/favorite/bool/$id'), headers: {
     'Content-Type': 'application/json',
     'Accept': 'application/json',
     'Authorization': 'Bearer ${PreferenceUtils.getString(Constant.token)}'
    });
    if (response.statusCode == 200) {
      return FavoriteResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Fail to load');
    }
  }

}