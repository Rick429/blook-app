import 'dart:convert';
import 'package:blook_app_flutter/constants.dart';
import 'package:blook_app_flutter/models/edit_user_dto.dart';
import 'package:blook_app_flutter/models/error_response.dart';
import 'package:blook_app_flutter/models/password_dto.dart';
import 'package:blook_app_flutter/models/user_dto.dart';
import 'package:blook_app_flutter/repository/user_repository/user_repository.dart';
import 'package:blook_app_flutter/utils/preferences.dart';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;

class UserRepositoryImpl extends UserRepository {
  final Client _client = Client();

  @override
  Future<User> uploadAvatar(String filename, String id) async{
    var request = http.MultipartRequest(
      'PUT', Uri.parse('${Constant.baseurl}user/avatar/$id'),);
    
      request.files.add(await http.MultipartFile.fromPath('file',filename));
    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer ${PreferenceUtils.getString('token')}' 
     
    };
     request.headers.addAll(headers);
    var res = await request.send();
    final respStr = await res.stream.bytesToString();
    if (res.statusCode == 200) {
      
      User userAvatar = User.fromJson(json.decode(respStr));
      PreferenceUtils.setString("avatar", userAvatar.avatar);
      return userAvatar;
    } else {
      final error = ErrorResponse.fromJson(json.decode(respStr));
      throw Exception(error.mensaje);
    }
  }

  @override
  Future<User> userLogged()async{
    final response = await _client.get(Uri.parse('${Constant.baseurl}me'), headers: {
     'Content-Type': 'application/json',
     'Accept': 'application/json',
     'Authorization': 'Bearer ${PreferenceUtils.getString(Constant.token)}'
    });
    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error al cargar el usuario');
    }
  }

  @override
  Future<User> changePassword(PasswordDto passwordDto) async {
   Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
      'Accept': 'application/json',
     'Authorization': 'Bearer ${PreferenceUtils.getString(Constant.token)}'
    };

    var request = http.MultipartRequest(
      'PUT',
      Uri.parse('${Constant.baseurl}user/change/'),
    );
    request.files.add(http.MultipartFile.fromString(
      'user',
      jsonEncode(passwordDto.toJson()),
      contentType: MediaType('application', 'json'),
      filename: "user",
    ));

    request.headers.addAll(headers);
    var res = await request.send();
    final respStr = await res.stream.bytesToString();
    if (res.statusCode == 200) {
      User user = User.fromJson(json.decode(respStr));
      return user;
    } else {
      final error = ErrorResponse.fromJson(json.decode(respStr));
      throw error;
    }
  }

  @override
  Future<User> edit(EditUserDto editUserDto, String id) async {
    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
      'Accept': 'application/json',
     'Authorization': 'Bearer ${PreferenceUtils.getString(Constant.token)}'
    };

    var request = http.MultipartRequest(
      'PUT',
      Uri.parse('${Constant.baseurl}user/$id'),
    );
    request.files.add(http.MultipartFile.fromString(
      'user',
      jsonEncode(editUserDto.toJson()),
      contentType: MediaType('application', 'json'),
      filename: "user",
    ));

    request.headers.addAll(headers);
    var res = await request.send();
    final respStr = await res.stream.bytesToString();
    if (res.statusCode == 200) {
      User user = User.fromJson(json.decode(respStr));
      return user;
    } else {
      final error = ErrorResponse.fromJson(json.decode(respStr));
      throw error;
    }
  }
}