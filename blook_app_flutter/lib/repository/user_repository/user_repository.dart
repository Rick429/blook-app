import 'package:blook_app_flutter/models/edit_user_dto.dart';
import 'package:blook_app_flutter/models/password_dto.dart';
import 'package:blook_app_flutter/models/user_dto.dart';

abstract class UserRepository {

  Future<User> uploadAvatar(String filename);
  
  Future<User> userLogged();

  Future<User> changePassword(PasswordDto passwordDto);

  Future<User> edit(EditUserDto editUserDto, String id);
}