import 'package:apod/database/database.dart';
import 'package:apod/models/apod.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'converse.dart';

class FavoritesDao {
  static const String tableFavorites = 'CREATE TABLE $nameTableFavorites('
      '$title       TEXT, '
      '$explanation TEXT, '
      '$hdurl       TEXT, '
      '$url         TEXT, '
      '$mediaType   TEXT, '
      '$copyright   TEXT, '
      '$datePhoto   TEXT PRIMARY KEY) ';

  Future<int> favorite(Apod apod) async {
    int saved = await save(apod);

    if (saved == null) {
      delete(apod.date);
      return 0;
    } else {
      return 1;
    }
  }

  Future<String> getDate(Apod apod) async {
    String dateApod = apod.date;
    List<String> dates = new List();

    String sqlQuery = "SELECT $datePhoto FROM $nameTableFavorites ";
    print(sqlQuery);

    final Database db = await (getDatabase());
    final List<Map<String, dynamic>> rows = await db.rawQuery(sqlQuery);

    for (Map<String, dynamic> row in rows) {
      dates.add(row[datePhoto]);
    }

    if (dates.isEmpty)
      return '';
    else if (dates.indexOf(dateApod) != -1)
      return dateApod;
    else
      return '';
  }

  Future<MaterialColor> getColorButton(Apod apod) async {
    String returnDate = await getDate(apod);

    if (returnDate == '') {
      return Colors.grey;
    } else {
      return Colors.red;
    }
  }

  Future<List<Apod>> findAll() async {
    final Database db = await (getDatabase());
    final List<Map<String, dynamic>> rows = await db.query(nameTableFavorites);
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

  Future<int> delete(String date) async {
    final Database db = await getDatabase();
    return db.delete(
      nameTableFavorites,
      where: '$datePhoto = ?',
      whereArgs: [date],
    );
  }

  Future<int> save(Apod apod) async {
    final Database db = await (getDatabase());
    return await db.insert(
      nameTableFavorites,
      toMap(apod),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }
}
