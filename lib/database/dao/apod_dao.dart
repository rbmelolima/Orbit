import 'package:apod/database/database.dart';
import 'package:apod/models/apod.dart';
import 'package:sqflite/sqflite.dart';

import 'converse.dart';

class ApodDao {
  static const String tablePOTD = 'CREATE TABLE $nameTablePOTD('
      '$id          INTEGER PRIMARY KEY, '
      '$title       TEXT,'
      '$explanation TEXT,'
      '$hdurl       TEXT,'
      '$url         TEXT,'
      '$mediaType   TEXT,'
      '$copyright   TEXT,'
      '$datePhoto   TEXT)';

  Future<int> savePOTD(Apod apod) async {
    /*
      Zerar dados da tabela
      Cadastrar dados
    */

    final Database db = await (getDatabase());
    final Map<String, dynamic> apodMap = toMap(apod);
    deleteAll(nameTablePOTD);
    print('// Salvando no banco de dados a foto do dia //');
    print(apodMap);
    return db.insert(nameTablePOTD, apodMap);
  }

  Future<List<Map<String, dynamic>>> seachPOTD() async {
    final Database db = await (getDatabase());
    final List<Map<String, dynamic>> result = await db.query(nameTablePOTD);
    print('PRINT DO RESULT');
    print(result);
    return result;
  }
  
  Future<int> deleteAll(String nameTable) async {
    final Database db = await getDatabase();
    return db.delete(
      nameTable,
    );
  }
}
