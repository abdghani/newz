import 'dart:io';
import 'package:dio/dio.dart';
import 'package:newz/util/keys.dart';
import 'package:newz/util/rawResponse.dart';

bool demo = false;
String baseUrl = 'https://newsapi.org/v2/';

dynamic getSourceNews(String src) async {
  if (demo == false) {
    String key = getKeys();
    String sourceUrl =
        "${baseUrl}top-headlines?sources=$src&apiKey=$key&pageSize=100";
    var response = await Dio().get(sourceUrl);
    return response.data;
  } else {
    // a future repsonse to mimic api
    return Future.delayed(Duration(milliseconds: 2000), () {
      return jsonrep;
    });
  }
}

dynamic getRegionNews(String code, String cat) async {
  if (demo == false) {
    String key = getKeys();
    String sourceUrl =
        "${baseUrl}top-headlines?country=$code&apiKey=$key&pageSize=100&category=$cat";
    var response = await Dio().get(sourceUrl);
    return response.data;
  } else {
    // a future repsonse to mimic api
    return Future.delayed(Duration(milliseconds: 2000), () {
      return jsonrep;
    });
  }
}

dynamic getCategoryNews(String catName) async {
  if (demo == false) {
    String key = getKeys();
    String sourceUrl =
        "${baseUrl}top-headlines?category=$catName&apiKey=$key&pageSize=100";
    var response = await Dio().get(sourceUrl);
    return response.data;
  } else {
    // a future repsonse to mimic api
    return Future.delayed(Duration(milliseconds: 2000), () {
      return jsonrep;
    });
  }
}
