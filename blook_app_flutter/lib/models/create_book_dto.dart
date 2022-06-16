class CreateBookDto {
  CreateBookDto({
    required this.name,
    required this.description,
    required this.generos
  });
  late final String name;
  late final String description;
  late final List<Object?> generos;

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['description'] = description;
    _data['generos'] = generos;
    return _data;
  }
}