import 'package:apod/database/dao/apod.dart';
import 'package:apod/database/dao/favorite.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  final String path = join(await (getDatabasesPath()), 'orbit.db');
  return openDatabase(path, onCreate: (db, version) {
    db.execute(APODdao.tablePOTD);
    db.execute(FavoritesDao.tableFavorites);
  }, version: 1);
}

Future<int> truncate(String nameTable) async {
  final Database db = await getDatabase();
  return db.delete(
    nameTable,
  );
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
