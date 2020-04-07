import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:apod/models/apod.dart';
import 'package:intl/intl.dart';
import 'Interceptor/interceptor.dart';

const String apiKey = 'tDUbr3ihJdiU5aLiKcvfAtur9f47eE4ztArwZFOH';

Client client = HttpClientWithInterceptor.build(
  interceptors: [LogginInterceptor()],
);

Future<Apod> searchImage(DateTime date) async {
  var formatter = new DateFormat('yyyy-MM-dd');

  String formattedDate =
      date == null ? formatter.format(DateTime.now()) : formatter.format(date);

  final response = await client.get(
      'https://api.nasa.gov/planetary/apod?api_key=$apiKey&date=$formattedDate');

  if (response.statusCode == 200)
    return Apod.fromJson(json.decode(response.body));
  else
    throw Exception('Falha ao buscar na API!');
}

Future<List<Apod>> searchWallpaper() async {
  final response = await client.get(
    'https://api.nasa.gov/planetary/apod?api_key=$apiKey&count=15',
  );

  if (response.statusCode == 200) {
    return compute(parseApod, response.body);
    //Pesquisar depois sobre a função compute
  } else
    throw Exception('Falha ao buscar na API!');
}

List<Apod> parseApod(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Apod>((json) => Apod.fromJson(json)).toList();
}
