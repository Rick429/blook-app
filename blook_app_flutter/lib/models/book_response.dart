import 'package:blook_app_flutter/models/comment_response.dart';
import 'package:blook_app_flutter/models/genre_response.dart';

class BookResponse {
  BookResponse({
    required this.content,
    required this.pageable,
    required this.last,
    required this.totalElements,
    required this.totalPages,
    required this.size,
    required this.number,
    required this.sort,
    required this.first,
    required this.numberOfElements,
    required this.empty,
  });
  late final List<Book> content;
  late final Pageable pageable;
  late final bool last;
  late final int totalElements;
  late final int totalPages;
  late final int size;
  late final int number;
  late final Sort sort;
  late final bool first;
  late final int numberOfElements;
  late final bool empty;
  
  BookResponse.fromJson(Map<String, dynamic> json){
    content = List.from(json['content']).map((e)=>Book.fromJson(e)).toList();
    pageable = Pageable.fromJson(json['pageable']);
    last = json['last'];
    totalElements = json['totalElements'];
    totalPages = json['totalPages'];
    size = json['size'];
    number = json['number'];
    sort = Sort.fromJson(json['sort']);
    first = json['first'];
    numberOfElements = json['numberOfElements'];
    empty = json['empty'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['content'] = content.map((e)=>e.toJson()).toList();
    _data['pageable'] = pageable.toJson();
    _data['last'] = last;
    _data['totalElements'] = totalElements;
    _data['totalPages'] = totalPages;
    _data['size'] = size;
    _data['number'] = number;
    _data['sort'] = sort.toJson();
    _data['first'] = first;
    _data['numberOfElements'] = numberOfElements;
    _data['empty'] = empty;
    return _data;
  }
}

class Book {
  Book({
    required this.id,
    required this.name,
    required this.description,
    required this.releaseDate,
    required this.cover,
    required this.autor,
    required this.chapters,
    required this.comments,
    required this.genres,
  });
  late final String id;
  late final String name;
  late final String description;
  late final String releaseDate;
  late final String cover;
  late final String autor;
  late final List<Chapter> chapters;
  late final List<Comment> comments;
  late final List<Genre> genres;

  Book.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    description = json['description'];
    releaseDate = json['releaseDate'];
    cover = json['cover'];
    autor = json['autor'];
    chapters = List.from(json['chapters']).map((e)=>Chapter.fromJson(e)).toList();
    comments = List.from(json['comments']).map((e)=>Comment.fromJson(e)).toList();
    genres = List.from(json['genres']).map((e)=>Genre.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['description'] = description;
    _data['releaseDate'] = releaseDate;
    _data['cover'] = cover;
    _data['autor'] = autor;
    _data['chapters'] = chapters.map((e)=>e.toJson()).toList();
    _data['comments'] = comments.map((e)=>e.toJson()).toList();
    _data['genres'] = genres.map((e)=>e.toJson()).toList();
    return _data;
  }
}

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


class Pageable {
  Pageable({
    required this.sort,
    required this.offset,
    required this.pageSize,
    required this.pageNumber,
    required this.unpaged,
    required this.paged,
  });
  late final Sort sort;
  late final int offset;
  late final int pageSize;
  late final int pageNumber;
  late final bool unpaged;
  late final bool paged;
  
  Pageable.fromJson(Map<String, dynamic> json){
    sort = Sort.fromJson(json['sort']);
    offset = json['offset'];
    pageSize = json['pageSize'];
    pageNumber = json['pageNumber'];
    unpaged = json['unpaged'];
    paged = json['paged'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['sort'] = sort.toJson();
    _data['offset'] = offset;
    _data['pageSize'] = pageSize;
    _data['pageNumber'] = pageNumber;
    _data['unpaged'] = unpaged;
    _data['paged'] = paged;
    return _data;
  }
}

class Sort {
  Sort({
    required this.empty,
    required this.unsorted,
    required this.sorted,
  });
  late final bool empty;
  late final bool unsorted;
  late final bool sorted;
  
  Sort.fromJson(Map<String, dynamic> json){
    empty = json['empty'];
    unsorted = json['unsorted'];
    sorted = json['sorted'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['empty'] = empty;
    _data['unsorted'] = unsorted;
    _data['sorted'] = sorted;
    return _data;
  }
}