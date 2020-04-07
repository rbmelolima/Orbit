import 'package:apod/models/apod.dart';

import '../database.dart';

Map<String, dynamic> toMap(Apod apod) {
  final Map<String, dynamic> apodMap = Map();
  apodMap[title] = apod.title;
  apodMap[explanation] = apod.explanation;
  apodMap[hdurl] = apod.hdurl;
  apodMap[url] = apod.url;
  apodMap[mediaType] = apod.mediaType;
  apodMap[copyright] = apod.copyright;
  apodMap[datePhoto] = apod.date;
  return apodMap;
}

List<Apod> toList(List<Map<String, dynamic>> result) {
  final List<Apod> apods = List();

  for (Map<String, dynamic> row in result) {
    final Apod apod = Apod(
      copyright: row[copyright],
      title: row[title],
      url: row[url],
      hdurl: row[hdurl],
      mediaType: row[mediaType],
      date: row[datePhoto],
      explanation: row[explanation],
    );
    apods.add(apod);
  }
  return apods;
}
