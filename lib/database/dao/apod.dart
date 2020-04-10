import 'package:apod/database/database.dart';
import 'package:apod/models/apod.dart';
import 'package:sqflite/sqflite.dart';
import 'converse.dart';

class APODdao {
  static const String tablePOTD = 'CREATE TABLE $nameTablePOTD('
      '$id          INTEGER PRIMARY KEY, '
      '$title       TEXT, '
      '$explanation TEXT, '
      '$hdurl       TEXT, '
      '$url         TEXT, '
      '$mediaType   TEXT, '
      '$copyright   TEXT, '
      '$datePhoto   TEXT) ';

  Future<int> save(Apod apod) async {
    truncate(nameTablePOTD);
    final Database db = await (getDatabase());
    final Map<String, dynamic> apodMap = toMap(apod);
    return db.insert(nameTablePOTD, apodMap);
  }

  Future<List<Apod>> search() async {
    final Database db = await (getDatabase());
    String sqlQuery = 'SELECT * FROM $nameTablePOTD LIMIT 1';
    final List<Map<String, dynamic>> rows = await db.rawQuery(sqlQuery);
    return (toList(rows));
  }

  Future<String> getDate() async {
    String sqlQuery = 'SELECT $datePhoto FROM $nameTablePOTD LIMIT 1';
    String data;
    String formattedData;

    final Database db = await (getDatabase());
    final List<Map<String, dynamic>> rows = await db.rawQuery(sqlQuery);

    for (Map<String, dynamic> row in rows) {
      data = row[datePhoto];
    }

    if (data == null)
      return '';
    else {
      formattedData = "$data 03:00:00";
      return formattedData;
    }
  }
}
