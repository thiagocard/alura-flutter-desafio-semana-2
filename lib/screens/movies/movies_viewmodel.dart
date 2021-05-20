import 'dart:async';

import 'package:flutter_app/repository/model/movie.dart';
import 'package:flutter_app/repository/movie_repository.dart';

class MoviesViewModel {

  var repo = MovieRepository();

  var _movies = StreamController<List<Movie>>.broadcast();

  Stream get movies => _movies.stream;

  void dispose() => _movies.close();

  void getPopularMovies() async {
    var popularMovies = await repo.getPopularMovies();
    List<int> favorites = await repo.findAllFavorites();
    var movies = popularMovies.map((tmdbMovie) =>
        _mapper.fromTmdbMovie(tmdbMovie, favorites.contains(tmdbMovie.id))).toList();
    _movies.add(popularMovies);
  }

}
