class LoginResponse {
  LoginResponse({
    required this.username,
    required this.email,
    required this.name,
    required this.lastname,
    required this.avatar,
    required this.role,
    required this.token,
  });
  late final String username;
  late final String email;
  late final String name;
  late final String lastname;
  late final String avatar;
  late final String role;
  late final String token;
  
  LoginResponse.fromJson(Map<String, dynamic> json){
    username = json['username'];
    email = json['email'];
    name = json['name'];
    lastname = json['lastname'];
    avatar = json['avatar'];
    role = json['role'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['username'] = username;
    _data['email'] = email;
    _data['name'] = name;
    _data['lastname'] = lastname;
    _data['avatar'] = avatar;
    _data['role'] = role;
    _data['token'] = token;
    return _data;
  }
}