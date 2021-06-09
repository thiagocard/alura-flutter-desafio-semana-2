import 'package:flutter_app/database/fav_movies_dao.dart';
import 'package:flutter_app/http/model/tmdb_movie.dart';
import 'package:flutter_app/http/tmdb_api.dart';
import 'package:flutter_app/repository/movie_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_repository_test.mocks.dart';

@GenerateMocks([TmdbApi, FavoriteMoviesDao])
void main() {
  test('Should check whether a movie is on favorites or not', () async {
    final dao = MockFavoriteMoviesDao();
    final repo = MovieRepositoryImpl(MockTmdbApi(), dao);

    when(dao.exists(1)).thenAnswer((_) async => true);

    final isFavorite = await repo.isMovieOnFavorites(1);

    expect(isFavorite, true);
  });

  test('Should get popular movies', () async {
    final api = MockTmdbApi();
    final repo = MovieRepositoryImpl(api, MockFavoriteMoviesDao());

    final expected = <TmdbMovie>[];
    when(api.getPopularMovies()).thenAnswer((_) async => expected);

    final popularMovies = await repo.getPopularMovies();

    expect(popularMovies, expected);
  });

  test('Should add a movie to favorites', () async {
    final dao = MockFavoriteMoviesDao();
    final repo = MovieRepositoryImpl(MockTmdbApi(), dao);

    when(dao.save(1)).thenAnswer((_) async => 1);

    final added = await repo.addToFavorites(1);

    expect(added, 1);
  });

  test('Should remove a movie from favorites', () async {
    final dao = MockFavoriteMoviesDao();
    final repo = MovieRepositoryImpl(MockTmdbApi(), dao);

    when(dao.remove(1)).thenAnswer((_) async => 1);

    final removed = await repo.removeFromFavorites(1);

    expect(removed, 1);
  });

  test('Should find all favorite movies', () async {
    final dao = MockFavoriteMoviesDao();
    final repo = MovieRepositoryImpl(MockTmdbApi(), dao);

    final expected = <int>[];
    when(dao.findAll()).thenAnswer((_) async => expected);

    final favorites = await repo.findAllFavorites();

    expect(favorites, expected);
  });
}
