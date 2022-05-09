class EditUserDto {
  EditUserDto({
    required this.name,
    required this.lastname,
    required this.email,
  });
  late final String name;
  late final String lastname;
  late final String email;

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['lastname'] = lastname;
    _data['email'] = email;
    return _data;
  }
}