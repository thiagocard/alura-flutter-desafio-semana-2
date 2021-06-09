import 'package:flutter_app/http/model/tmdb_movie.dart';
import 'package:flutter_app/mappers/movie_mapper.dart';
import 'package:flutter_app/repository/movie_repository.dart';
import 'package:flutter_app/screens/movies/movies_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movies_vm_test.mocks.dart';

@GenerateMocks([MovieRepository])
void main() {
  test('fac', () async {
    final repo = MockMovieRepository();
    final vm = MoviesViewModel(repo, MovieMapper());

    when(repo.getPopularMovies()).thenAnswer((_) async {
      return [
        TmdbMovie(1, 'Batman', null, null, null),
        TmdbMovie(2, 'Spider Man', null, null, null),
        TmdbMovie(3, 'The Flash', null, null, null),
      ];
    });

    when(repo.findAllFavorites()).thenAnswer((_) async => [1]);

    vm.getPopularMovies();

    vm.movies.listen((event) {
      expect(event.length, 3);
      expect(event[0].isFavorite, true);
      expect(event[1].isFavorite, false);
      expect(event[2].isFavorite, false);
    });

    // expectAsync1((event) {
    //   expect(event, []);
    // });
  });
}
