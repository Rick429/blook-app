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
      PreferenceUtils.setString('username', userLogged.username);
      return userLogged;
    } else {
      final error = ErrorResponse.fromJson(json.decode(response.body));
      throw Exception(error.mensaje);
    }
  }

  @override
  Future<LoginResponse> register(RegisterDto registerDto) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json'
    };

      final response = await _client.post(
        Uri.parse('${Constant.baseurl}auth/register'),
        headers: headers,
        body: jsonEncode(registerDto.toJson()));
    

    if (response.statusCode == 201) {
      LoginResponse userLogged = LoginResponse.fromJson(json.decode(response.body));
      PreferenceUtils.setString('token', userLogged.token);
      PreferenceUtils.setString('username', userLogged.username);
      return userLogged;
    } else {
      final error = ErrorResponse.fromJson(json.decode(response.body));
      throw Exception(error.mensaje);
    }
  }
}