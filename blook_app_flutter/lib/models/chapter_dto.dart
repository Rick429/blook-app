class Chapter {
  Chapter({
    required this.id,
    required this.name,
    required this.file,
  });
  late final String id;
  late final String name;
  late final String file;
  
  Chapter.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    file = json['file'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['file'] = file;
    return _data;
  }
}