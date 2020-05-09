import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:apod/models/apod.dart';
import 'Interceptor/interceptor.dart';

const String apiKey = 'tDUbr3ihJdiU5aLiKcvfAtur9f47eE4ztArwZFOH';

Client client = HttpClientWithInterceptor.build(
  interceptors: [LogginInterceptor()],
);

Future<List<Apod>> searchWallpaper() async {
  final response = await client.get(
    'https://api.nasa.gov/planetary/apod?api_key=$apiKey&count=20',
  );

  switch (response.statusCode) {
    case 200:
      return compute(parseApod, response.body);

    default:
      throw Exception('Informe isso ao desenvolvedor - HTTP Status ' +
          response.statusCode.toString());
      break;
  }
}

List<Apod> parseApod(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Apod>((json) => Apod.fromJson(json)).toList();
}
