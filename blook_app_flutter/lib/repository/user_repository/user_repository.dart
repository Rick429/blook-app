import 'package:blook_app_flutter/models/user_dto.dart';

abstract class UserRepository {

  Future<User> uploadAvatar(String filename);
  
  Future<User> userLogged();
}