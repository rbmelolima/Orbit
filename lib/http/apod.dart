import 'dart:convert';
import 'package:apod/database/dao/apod.dart';
import 'package:apod/database/database.dart';
import 'package:apod/http/key.dart';
import 'package:apod/models/apod.dart';
import 'package:intl/intl.dart';
import 'Interceptor/interceptor.dart';

var formatter = new DateFormat('yyyy-MM-dd');

Future<Apod> searchImage(DateTime date) async {
  String formattedDate =
      date == null ? formatter.format(DateTime.now()) : formatter.format(date);

  final response = await client.get(
      'https://api.nasa.gov/planetary/apod?api_key=$apiKey&date=$formattedDate');

  switch (response.statusCode) {
    case 200:
      return Apod.fromJson(json.decode(response.body));

    default:
      throw Exception('Informe isso ao desenvolvedor - HTTP Status ' +
          response.statusCode.toString());
      break;
  }
}

Future<Apod> cacheApod(DateTime searchDate) async {
  if (searchDate != null &&
      formatter.format(searchDate) != formatter.format(DateTime.now())) {
    return searchImage(searchDate);
  }

  final APODdao fotoDia = APODdao();
  DateTime dataAtual = DateTime.now();
  String dataFoto = await fotoDia.getDate();

  switch (dataFoto) {
    case '':
      Apod apod = await searchImage(searchDate);
      if (apod != null) fotoDia.save(apod);
      return apod;

    default:
      DateTime parsedData = DateTime.parse(dataFoto);
      Duration difference = dataAtual.difference(parsedData);
      int diff = difference.inDays;

      if (diff >= 1) {
        truncate(nameTablePOTD);
        fotoDia.save(await searchImage(searchDate));
        return searchImage(searchDate);
      } else {
        List<Apod> listApod = await fotoDia.search();
        Apod returnApod = Apod(
          copyright: listApod[0].copyright,
          date: listApod[0].date,
          explanation: listApod[0].explanation,
          hdurl: listApod[0].hdurl,
          mediaType: listApod[0].mediaType,
          title: listApod[0].title,
          url: listApod[0].url,
        );
        return returnApod;
      }
      break;
  }
}
