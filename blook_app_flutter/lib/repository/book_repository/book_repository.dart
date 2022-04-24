import 'package:blook_app_flutter/models/book_response.dart';
import 'package:blook_app_flutter/models/create_book_dto.dart';

abstract class BookRepository {

  Future<Book> createBook(CreateBookDto createBookDto, String filename);

  Future<List<Book>>fetchMyBooks();

  Future<Book> findBookById(String id);
  
  Future<Book> addFavoriteBook(String id);

  Future<List<Book>>fetchMyFavoriteBooks();
}