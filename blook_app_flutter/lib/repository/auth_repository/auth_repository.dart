import 'package:blook_app_flutter/models/login_dto.dart';
import 'package:blook_app_flutter/models/login_response.dart';
import 'package:blook_app_flutter/models/register_dto.dart';

abstract class AuthRepository {
  Future<LoginResponse> login(LoginDto loginDto);

  Future<LoginResponse> register(RegisterDto registerDto, filepath);
  
}
