import 'dart:async';

import 'package:flutter_app/mappers/movie_mapper.dart';
import 'package:flutter_app/repository/model/movie.dart';
import 'package:flutter_app/repository/movie_repository.dart';

class MoviesViewModel {

  var _repo = MovieRepository();
  var _mapper = MovieMapper();

  var _movies = StreamController<List<Movie>>.broadcast();
  Stream<List<Movie>> get movies => _movies.stream;

  void dispose() => _movies.close();

  void getPopularMovies() async {
    var popularMovies = await _repo.getPopularMovies();
    List<int> favorites = await _repo.findAllFavorites();
    var movies = popularMovies.map((tmdbMovie) =>
        _mapper.fromTmdbMovie(tmdbMovie, favorites.contains(tmdbMovie.id))).toList();
    _movies.add(movies);
  }

}
