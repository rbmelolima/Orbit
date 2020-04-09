import 'package:apod/database/database.dart';
import 'package:apod/models/apod.dart';
import 'package:sqflite/sqflite.dart';
import 'converse.dart';

class FavoritesDao {
  static const String tableFavorites = 'CREATE TABLE $nameTableFavorites('
      '$id          INTEGER PRIMARY KEY, '
      '$title       TEXT, '
      '$explanation TEXT, '
      '$hdurl       TEXT, '
      '$url         TEXT, '
      '$mediaType   TEXT, '
      '$copyright   TEXT, '
      '$datePhoto   TEXT) ';

  Future<int> favorite(Apod apod) async {
    print('// Salvando a foto favorita //');
    final Database db = await (getDatabase());

    Future<bool> existsPhoto = getDate();

    if (await existsPhoto == true) {
      print('Essa foto já foi favoritada');
      return 0;
    } else {
      print('Foto favoritada com sucesso');
      final Map<String, dynamic> apodMap = toMap(apod);
      return db.insert(nameTableFavorites, apodMap);
    }
  }

  Future<List<Apod>> findAll() async {
    print('// Procurando todas as fotos favoritas //');
    final Database db = await (getDatabase());
    String sqlQuery = 'SELECT * FROM $nameTableFavorites';
    final List<Map<String, dynamic>> rows = await db.rawQuery(sqlQuery);
    return (toList(rows));
  }

  Future<Apod> search(String date) async {
    final Database db = await getDatabase();
    String sqlQuery =
        'SELECT * FROM $nameTablePOTD WHERE $datePhoto = $date LIMIT 1';
    final List<Map<String, dynamic>> rows = await db.rawQuery(sqlQuery);
    Apod apod;
    for (Map<String, dynamic> row in rows) {
      apod = Apod.fromJson(row);
    }
    return apod;
  }

  Future<bool> getDate() async {
    print('// Procurando a data da foto do dia //');
    String sqlQuery = 'SELECT $datePhoto FROM $nameTableFavorites LIMIT 1';
    String data;

    final Database db = await (getDatabase());
    final List<Map<String, dynamic>> rows = await db.rawQuery(sqlQuery);

    for (Map<String, dynamic> row in rows) {
      data = row[datePhoto];
    }

    if (data == null) {
      return false;
    } else {
      return true;
    }
  }

  Future<int> delete(String date) async {
    final Database db = await getDatabase();
    return db.delete(
      nameTableFavorites,
      where: '$datePhoto = ?',
      whereArgs: [date],
    );
  }
}
