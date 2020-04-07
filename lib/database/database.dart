import 'package:apod/database/dao/apod_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  final String path = join(await (getDatabasesPath()), 'orbit.db');
  return openDatabase(path, onCreate: (db, version) {
    db.execute(ApodDao.tablePOTD);
  }, version: 1);
}

const String nameTablePOTD = 'photoOfTheDay';
const String nameTableFavorites = 'favorites';
const String nameTableWallpapers = 'wallpapers';
const String id = 'id';
const String title = 'title';
const String explanation = 'explanation';
const String hdurl = 'hdurl';
const String url = 'url';
const String mediaType = 'mediaType';
const String copyright = 'copyright';
const String datePhoto = 'datePhoto';
