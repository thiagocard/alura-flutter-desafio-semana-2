import 'package:flutter_app/database/app_database.dart';
import 'package:flutter_app/database/fav_movies_dao.dart';
import 'package:flutter_app/http/model/tmdb_movie.dart';
import 'package:flutter_app/http/tmdb_api.dart';

class MovieRepository {
  var _api = TmdbApi();
  var _favMoviesDao = FavoriteMoviesDao();

  Future<List<TmdbMovie>> getPopularMovies() => _api.getPopularMovies();

  isMovieOnFavorites(int id) => _favMoviesDao.exists(id);

  addToFavorites(int id) => _favMoviesDao.save(id);

  removeFromFavorites(int id) => _favMoviesDao.remove(id);

  Future<List<int>> findAllFavorites() => _favMoviesDao.findAll();
}
