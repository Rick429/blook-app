class User {
  User({
    required this.id,
    required this.nick,
    required this.name,
    required this.lastname,
    required this.email,
    required this.avatar,
    required this.role,
    required this.libros,
  });
  late final String id;
  late final String nick;
  late final String name;
  late final String lastname;
  late final String email;
  late final String avatar;
  late final String role;
  late final List<dynamic> libros;
  
  User.fromJson(Map<String, dynamic> json){
    id = json['id'];
    nick = json['nick'];
    name = json['name'];
    lastname = json['lastname'];
    email = json['email'];
    avatar = json['avatar'];
    role = json['role'];
    libros = List.castFrom<dynamic, dynamic>(json['libros']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['nick'] = nick;
    _data['name'] = name;
    _data['lastname'] = lastname;
    _data['email'] = email;
    _data['avatar'] = avatar;
    _data['role'] = role;
    _data['libros'] = libros;
    return _data;
  }
}