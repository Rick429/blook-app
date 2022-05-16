import 'package:blook_app_flutter/models/book_response.dart';
import 'package:blook_app_flutter/models/create_book_dto.dart';
import 'package:blook_app_flutter/models/favorite_response.dart';
import 'package:blook_app_flutter/models/search_dto.dart';

abstract class BookRepository {

  Future<Book> createBook(CreateBookDto createBookDto, String filename);

  Future<BookResponse>fetchMyBooks(int size, String sortedList);

  Future<Book> findBookById(String id);
  
  Future<Book> addFavoriteBook(String id);

  Future<BookResponse>fetchMyFavoriteBooks(int size);

  Future<List<Book>> fetchBooks(String type);

  Future<List<Book>> findBook(SearchDto searchDto);

  void deleteBook(String id);

  void removeFavorite (String id);

  Future<FavoriteResponse> isFavorite(String id);

  Future<Book> editBook(CreateBookDto editBookDto, String id);

  Future<Book> editCoverBook(String filename, String id);

}