import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

Future<String> getApiKey() async {
  String json = await rootBundle.loadString('secrets.json');
  return jsonDecode(json)['api_key'];
}

dynamic requestInterceptor(RequestOptions options) async {
  options.queryParameters['api_key'] = await getApiKey();
  return options;
}
