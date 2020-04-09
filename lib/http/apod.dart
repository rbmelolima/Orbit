import 'dart:convert';
import 'package:apod/database/dao/apod.dart';
import 'package:apod/database/database.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:apod/models/apod.dart';
import 'package:intl/intl.dart';
import 'Interceptor/interceptor.dart';

const String apiKey = 'tDUbr3ihJdiU5aLiKcvfAtur9f47eE4ztArwZFOH';
var formatter = new DateFormat('yyyy-MM-dd');

Client client = HttpClientWithInterceptor.build(
  interceptors: [LogginInterceptor()],
);

Future<Apod> searchImage(DateTime date) async {
  DateTime searchDate = date;

  String formattedDate =
      date == null ? formatter.format(DateTime.now()) : formatter.format(date);

  final response = await client.get(
      'https://api.nasa.gov/planetary/apod?api_key=$apiKey&date=$formattedDate');

  switch (response.statusCode) {
    case 200:
      return cache(response, searchDate);

    default:
      throw Exception('Falha ao buscar na API!');
      break;
  }
}

Future<Apod> cache(Response response, DateTime searchDate) async {
  if (searchDate != null &&
      formatter.format(searchDate) != formatter.format(DateTime.now())) {
    print('Mostrando foto do dia $searchDate');
    return Apod.fromJson(json.decode(response.body));
  }

  final APODdao fotoDia = APODdao();
  DateTime dataAtual = DateTime.now();
  String dataFoto = await fotoDia.getDate();

  if (dataFoto == '') {
    print(
        'Não há nada no banco de dados, vou retornar os dados da API e salvar no bdd a foto do dia');
    Apod apod = Apod.fromJson(json.decode(response.body));
    fotoDia.save(apod);
    return apod;
  } else {
    print('Encontrei algo no banco relacionado à foto do dia');
    DateTime parsedData = DateTime.parse(dataFoto);
    Duration difference = dataAtual.difference(parsedData);
    int diff = difference.inDays;

    if (diff >= 1) {
      print(
          'A diferença da foto do banco e a data atual ($dataAtual) é maior que um dia!');
      truncate(nameTablePOTD);
      return Apod.fromJson(json.decode(response.body));
    } else {
      print(
          'A diferença das datas é menor que um dia! Vou servir o que está no banco :)');
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
  }
}
