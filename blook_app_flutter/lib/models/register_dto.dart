class RegisterDto {
  RegisterDto({
    required this.nick,
    required this.name,
    required this.lastname,
    required this.email,
    required this.password,
    required this.password2,
  });
  late final String nick;
  late final String name;
  late final String lastname;
  late final String email;
  late final String password;
  late final String password2;

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['nick'] = nick;
    _data['name'] = name;
    _data['lastname'] = lastname;
    _data['email'] = email;
    _data['password'] = password;
    _data['password2'] = password2;
    return _data;
  }
}
