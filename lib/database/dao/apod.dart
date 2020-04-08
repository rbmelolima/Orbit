import 'package:apod/database/database.dart';
import 'package:apod/models/apod.dart';
import 'package:sqflite/sqflite.dart';
import 'converse.dart';

//POTD Significa "Picture of the day"

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
    print('// Salvando, na tabela $nameTablePOTD, a foto do dia //');
    final Database db = await (getDatabase());
    final Map<String, dynamic> apodMap = toMap(apod);
    return db.insert(nameTablePOTD, apodMap);
  }

  Future<List<Apod>> search() async {
    print('// Procurando, na tabela $nameTablePOTD, a foto do dia //');
    final Database db = await (getDatabase());
    String sqlQuery = 'SELECT * FROM $nameTablePOTD LIMIT 1';
    final List<Map<String, dynamic>> rows = await db.rawQuery(sqlQuery);
    return (toList(rows));
  }

  Future<int> truncate(String nameTable) async {
    print('// Apagando todas as informações da tabela: $nameTable //');
    final Database db = await getDatabase();
    return db.delete(
      nameTable,
    );
  }

  Future<String> getDate() async {
    print('// Procurando a data da foto do dia //');
    String sqlQuery = 'SELECT $datePhoto FROM $nameTablePOTD LIMIT 1';
    String data;
    String formattedData;

    final Database db = await (getDatabase());
    final List<Map<String, dynamic>> rows = await db.rawQuery(sqlQuery);

    for (Map<String, dynamic> row in rows) {
      data = row[datePhoto];
    }

    if (data == null) {
      return '';
    } else {
      formattedData = "$data 00:00:00";
      return formattedData;
    }
  }
}