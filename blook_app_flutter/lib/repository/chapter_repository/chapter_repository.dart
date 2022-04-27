import 'package:blook_app_flutter/models/book_response.dart';
import 'package:blook_app_flutter/models/chapter_dto.dart';
import 'package:blook_app_flutter/models/create_chapter_dto.dart';

abstract class ChapterRepository {

  Future<Chapter> createChapter(CreateChapterDto createChapterDto, String filename, String idbook);
  
  void deleteChapter(String id);
}