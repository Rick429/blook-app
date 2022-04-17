import 'package:blook_app_flutter/models/book_dto.dart';
import 'package:blook_app_flutter/models/create_book_dto.dart';

abstract class BookRepository {

  Future<Book> createBook(CreateBookDto createBookDto, String filename);
  
}