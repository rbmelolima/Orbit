import 'dart:convert';
import 'package:apod/http/key.dart';
import 'package:flutter/foundation.dart';
import 'package:apod/models/apod.dart';
import 'Interceptor/interceptor.dart';


Future<List<Apod>> searchWallpaper() async {
  final response = await client.get(
    'https://api.nasa.gov/planetary/apod?api_key=$apiKey&count=20',
  );

  switch (response.statusCode) {
    case 200:
      return compute(parseApod, response.body);

    default:
      throw Exception('HTTP Status ' +
          response.statusCode.toString());
      break;
  }
}

List<Apod> parseApod(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Apod>((json) => Apod.fromJson(json)).toList();
}
