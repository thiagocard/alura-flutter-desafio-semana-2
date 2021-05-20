import 'package:flutter_app/database/app_database.dart';
import 'package:sqflite/sqflite.dart';

class FavoriteMoviesDao {

  static const String _table = 'movies';
  static const String _id = 'id';

  static const String createTableStatement =
      'CREATE TABLE IF NOT EXISTS $_table('
      '$_id INTEGER PRIMARY KEY'
      ')';

  Future<int> save(int id) async {
    Database db = await AppDatabase.database;
    Map<String, dynamic> movieMap = mapFavoriteMovieId(id);
    return db.insert('movies', movieMap);
  }

  Future<List<int>> findAll() async {
    openDatabase('', onCreate: (db, version) {});
    Database db = await AppDatabase.database;
    List<Map<String, dynamic>> maps = await db.query(_table);
    List<int> movies = maps.map((map) => map[_id] as int).toList();
    return movies;
  }

  Future<bool> exists(int id) async {
    Database db = await AppDatabase.database;
    List<Map<String, dynamic>> maps =
        await db.query(_table, where: '$_id = ?', whereArgs: [id]);
    if (maps.length > 0) {
      return true;
    }
    return false;
  }

  Map<String, dynamic> mapFavoriteMovieId(int id) {
    final Map<String, dynamic> movieMap = Map();
    movieMap[_id] = id;
    return movieMap;
  }

  Future<int> remove(int id) async {
    Database db = await AppDatabase.database;
    return db.delete(_table, where: '$_id = ?', whereArgs: [id]);
  }

}
