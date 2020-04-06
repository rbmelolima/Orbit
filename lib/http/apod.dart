import 'dart:convert';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:apod/models/apod.dart';
import 'package:intl/intl.dart';

const String apiKey = 'tDUbr3ihJdiU5aLiKcvfAtur9f47eE4ztArwZFOH';

class LogginInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    print(data);
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async {
    print(data);
    return data;
  }
}

Future<Apod> searchImage(DateTime date) async {
  Client client =
      HttpClientWithInterceptor.build(interceptors: [LogginInterceptor()]);

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
