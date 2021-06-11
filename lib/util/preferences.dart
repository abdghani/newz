import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

const PREF = "APP_PREFERENCES";

class PrefProvider with ChangeNotifier {
  dynamic _prefs;
  dynamic get prefs => _prefs;

  setAppPreferences(Map<String, dynamic> userPrefs) async {
    print(userPrefs);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(PREF, jsonEncode(userPrefs));
    _prefs = userPrefs;
  }

  getAppPreferences() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? fromPref = await prefs.getString(PREF);
      dynamic fetchedPrefs = jsonDecode(fromPref!);
      return fetchedPrefs;
    } catch (err) {
      return null;
    }
  }

  setInitialPreferences() async {
    dynamic prefs = await getAppPreferences();
    if (prefs == null) {
      prefs = {"defaultEnglish": false};
      await setAppPreferences(prefs);
    }
    _prefs = prefs;
    notifyListeners();
  }
}
