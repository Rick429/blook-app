class Book {
  Book({
    required this.id,
    required this.name,
    required this.description,
    required this.relaseDate,
    required this.cover,
    required this.chapters,
    required this.comments,
  });
  late final String id;
  late final String name;
  late final String description;
  late final String relaseDate;
  late final String cover;
  late final List<dynamic> chapters;
  late final List<dynamic> comments;
  
  Book.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    description = json['description'];
    relaseDate = json['relase_date'];
    cover = json['cover'];
    chapters = List.castFrom<dynamic, dynamic>(json['chapters']);
    comments = List.castFrom<dynamic, dynamic>(json['comments']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['description'] = description;
    _data['relase_date'] = relaseDate;
    _data['cover'] = cover;
    _data['chapters'] = chapters;
    _data['comments'] = comments;
    return _data;
  }
}