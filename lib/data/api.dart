import 'dart:io';
import 'package:dio/dio.dart';
import 'package:newz/util/keys.dart';
import 'package:newz/util/rawResponse.dart';

String baseUrl = 'https://newsapi.org/v2/';

dynamic getSourceNews(String src) async {
  try {
    String key = getKeys();
    String sourceUrl = "${baseUrl}top-headlines?sources=$src&apiKey=$key";
    var response = await Dio().get(sourceUrl);
    return response.data;
    // return Future.delayed(Duration(milliseconds: 2000), () {
    //   return jsonrep;
    // });
  } catch (err) {
    rethrow;
  }
}
