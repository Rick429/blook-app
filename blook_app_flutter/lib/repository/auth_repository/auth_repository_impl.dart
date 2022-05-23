import 'dart:convert';
import 'package:blook_app_flutter/models/error_response.dart';
import 'package:blook_app_flutter/models/login_dto.dart';
import 'package:blook_app_flutter/models/login_response.dart';
import 'package:blook_app_flutter/models/register_dto.dart';
import 'package:blook_app_flutter/utils/preferences.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import '../../constants.dart';
import 'auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final Client _client = Client();

  @override
  Future<LoginResponse> login(LoginDto loginDto) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json'
    };

    final response = await _client.post(
        Uri.parse('${Constant.baseurl}auth/login'),
        headers: headers,
        body: jsonEncode(loginDto.toJson()));
    if (response.statusCode == 201) {
      LoginResponse userLogged = LoginResponse.fromJson(json.decode(response.body));
      PreferenceUtils.setString('nick', userLogged.nick);
      if(userLogged.avatar.isEmpty){
        PreferenceUtils.setString('avatar', '');
      }else {
        PreferenceUtils.setString('avatar', userLogged.avatar);
      }
      return userLogged;
    } else {
      final error = ErrorResponse.fromJson(json.decode(response.body));
      throw Exception(error.mensaje);
    }
  }

  @override
  Future<LoginResponse> register(RegisterDto registerDto) async {
     Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
    };

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('${Constant.baseurl}auth/register'),
    );
    request.files.add(http.MultipartFile.fromString(
      'user',
      jsonEncode(registerDto.toJson()),
      contentType: MediaType('application', 'json'),
      filename: "user",
    ));

    request.headers.addAll(headers);
    var res = await request.send();
    final respStr = await res.stream.bytesToString();
    if (res.statusCode == 201) {
      LoginResponse userLogged = LoginResponse.fromJson(json.decode(respStr));
      PreferenceUtils.setString('nick', userLogged.nick);
      if(userLogged.avatar.isEmpty){
        PreferenceUtils.setString('avatar', '');
      }else {
        PreferenceUtils.setString('avatar', userLogged.avatar);
      }
      return userLogged;
    } else {
      final error = ErrorResponse.fromJson(json.decode(respStr));
      throw error;
    }
  }
}