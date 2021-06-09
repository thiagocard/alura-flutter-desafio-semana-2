import 'package:flutter_app/http/model/tmdb_movie.dart';
import 'package:flutter_app/repository/movie_repository.dart';
import 'package:flutter_app/screens/movie_details/movie_detail_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movies_vm_test.mocks.dart';

@GenerateMocks([MovieRepository])
void main() {
  test('Given a movie id, should listen to its initial favorite state', () async {
    final repo = MockMovieRepository();
    final vm = MovieDetailViewModel(repo);

    when(repo.isMovieOnFavorites(1)).thenAnswer((_) async => true);

    vm.setMovieId(1);

    vm.isFavorite.listen((event) {
      expect(event, true);
    });
  });

  test('Given a movie flagged as favorite, should remove it from favorites when calling addOrRemoveToFavorites', () async {
    final repo = MockMovieRepository();
    final vm = MovieDetailViewModel(repo);

    when(repo.isMovieOnFavorites(1)).thenAnswer((_) async => true);
    when(repo.removeFromFavorites(1)).thenAnswer((_) async => 1);

    vm.setMovieId(1);
    await vm.addOrRemoveToFavorites(1);

    vm.isFavorite.listen((event) {
      expect(event, false);
    });
  });

  test('Given a movie (not flagged as favorite), should add it to favorites when calling addOrRemoveToFavorites', () async {
    final repo = MockMovieRepository();
    final vm = MovieDetailViewModel(repo);

    when(repo.isMovieOnFavorites(1)).thenAnswer((_) async => false);
    when(repo.addToFavorites(1)).thenAnswer((_) async => 1);

    vm.setMovieId(1);
    await vm.addOrRemoveToFavorites(1);

    vm.isFavorite.listen((event) {
      expect(event, true);
    });
  });
}
