import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_app/http/model/tmdb_movie.dart';
import 'package:retrofit/retrofit.dart';

class TmdbApi {
  Dio _dio = Dio(BaseOptions(baseUrl: 'https://api.themoviedb.org/3/'));
  Map<String, dynamic> authParams = {
    'api_key': 'd0a02dc304aa2511cae98ef27dde69a6'
  };

  @GET('movie/popular')
  Future<List<TmdbMovie>> getPopularMovies() async {
    var response = await _dio.get('movie/popular', queryParameters: authParams);
    var body = response.data;
    var map = List<TmdbMovie>.from(
        body['results'].map((item) =>
            TmdbMovie(item['id'], item['title'], item['poster_path'], item['backdrop_path'], item['overview'])
        ).toList()
    );
    return map;
  }
}
