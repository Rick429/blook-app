import 'package:blook_app_flutter/models/genre_response.dart';

abstract class GenreRepository {

  Future<List<Genre>>  fetchAllGenres();
  
}