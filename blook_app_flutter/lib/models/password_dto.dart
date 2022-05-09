class PasswordDto {
  PasswordDto({
    required this.password,
    required this.passwordNew,
    required this.passwordNew2,
  });
  late final String password;
  late final String passwordNew;
  late final String passwordNew2;

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['password'] = password;
    _data['passwordNew'] = passwordNew;
    _data['passwordNew2'] = passwordNew2;
    return _data;
  }
}
