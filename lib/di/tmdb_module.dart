import 'package:flutter_app/mappers/movie_mapper.dart';
import 'package:get_it/get_it.dart';

class MapperModule {

  MapperModule._();

  static final _getIt = GetIt.instance;

  static void provide() {
    _getIt.registerFactory(() => MovieMapper());
  }

}