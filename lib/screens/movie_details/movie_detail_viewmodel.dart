import 'dart:async';

import 'package:flutter_app/repository/movie_repository.dart';

class MovieDetailViewModel {

  final MovieRepository _repo = MovieRepository();

  final StreamController<int> _movieId = StreamController<int>();

  StreamController<bool> _isFavorite = StreamController<bool>();
  Stream<bool> get isFavorite => _isFavorite.stream;

  MovieDetailViewModel() {
    _movieId.stream.listen((id) async {
      var isOnFavorites = await _repo.isMovieOnFavorites(id);
      _isFavorite.add(isOnFavorites);
    });
  }

  void setMovieId(int id) => _movieId.add(id);

  void dispose() {
    _movieId.close();
    _isFavorite.close();
  }

  void addOrRemoveToFavorites(int id) async {
    if (await _repo.isMovieOnFavorites(id)) {
      var removed = await _repo.removeFromFavorites(id);
      if (removed > 0) {
        setMovieId(id);
      }
    } else {
      var saved = await _repo.addToFavorites(id);
      if (saved > 0) {
        setMovieId(id);
      }
    }
  }
}
