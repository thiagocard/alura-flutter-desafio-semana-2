import 'package:flutter_app/repository/movie_repository.dart';
import 'package:get_it/get_it.dart';

class RepositoryModule {

  RepositoryModule._();

  static final _getIt = GetIt.instance;

  static void provide() {
    _getIt.registerFactory<MovieRepository>(() => MovieRepositoryImpl());
  }

}