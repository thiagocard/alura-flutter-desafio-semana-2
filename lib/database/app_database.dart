import 'package:flutter_app/database/fav_movies_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  static Future<Database> get database async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'database.db');
    return openDatabase(path,
        onCreate: (db, version) =>
            db.execute(FavoriteMoviesDao.createTableStatement),
        version: 1);
  }
}
