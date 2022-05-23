import 'dart:convert';
import 'package:blook_app_flutter/constants.dart';
import 'package:blook_app_flutter/models/genre_response.dart';
import 'package:blook_app_flutter/repository/genre_repository/genre_repository.dart';
import 'package:blook_app_flutter/utils/preferences.dart';
import 'package:http/http.dart';

class GenreRepositoryImpl extends GenreRepository {
  final Client _client = Client();

  @override
  Future<List<Genre>> fetchAllGenres() async {
    final response = await _client.get(Uri.parse('${Constant.baseurl}genre/all?size=100'), headers: {
     'Content-Type': 'application/json',
     'Accept': 'application/json',
     'Authorization': 'Bearer ${PreferenceUtils.getString(Constant.token)}'
    });
    if (response.statusCode == 200) {
      return GenreResponse.fromJson(json.decode(response.body)).content;
    } else {
      throw Exception('Fail to load genres');
    }
  }
}