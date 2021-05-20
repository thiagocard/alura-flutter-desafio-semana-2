import 'package:flutter_app/http/model/tmdb_movie.dart';
import 'package:flutter_app/repository/model/movie.dart';

class MovieMapper {

  static final basePosterPath = 'https://image.tmdb.org/t/p/w342';
  static final baseBackdropPath = 'https://image.tmdb.org/t/p/w780';
  
  Movie fromTmdbMovie(TmdbMovie tmdbMovie, bool isFavorite) {
    return Movie(
        tmdbMovie.id,
        tmdbMovie.title,
        '$basePosterPath${tmdbMovie.poster}',
        '$baseBackdropPath${tmdbMovie.backdrop}',
        tmdbMovie.overview,
        isFavorite
    ); 
  }
  
}