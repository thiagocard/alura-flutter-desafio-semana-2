
import 'package:flutter_app/repository/model/movie.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  test('Should create a movie with success', () {
    final movie = Movie(1, 'Batman: The Dark Knight', '/poster.png', '/backdrop.png', 'Bla bla bla');
    expect(movie.id, 1);
    expect(movie.title, 'Batman: The Dark Knight');
    expect(movie.poster, '/poster.png');
    expect(movie.backdrop, '/backdrop.png');
    expect(movie.overview, 'Bla bla bla');
    expect(movie.isFavorite, false);
  });

  test('Should throw an error when id is less than zero', () {
    expect(() => Movie(-1, null, null, null, null), throwsAssertionError);
  });

}