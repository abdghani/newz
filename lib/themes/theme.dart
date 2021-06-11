import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class MyThemes with ChangeNotifier {
  static bool _isDark = false;

  static ThemeData lightTheme = ThemeData(
      fontFamily: 'RobotoCondensed',
      primaryColor: Color.fromRGBO(233, 75, 136, 1.0),
      accentColor: Color.fromRGBO(247, 247, 247, 1.0),
      splashColor: Colors.transparent,
      backgroundColor: Color.fromRGBO(254, 254, 254, 1.0),
      textTheme: TextTheme(
          headline1: GoogleFonts.raleway(
            color: Colors.black,
            fontSize: 45,
            fontWeight: FontWeight.bold,
          ),
          headline2: GoogleFonts.raleway(
            color: Colors.black,
            fontSize: 35,
            fontWeight: FontWeight.bold,
          ),
          headline3: GoogleFonts.raleway(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
          headline4: GoogleFonts.raleway(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
          headline5: GoogleFonts.raleway(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          headline6: GoogleFonts.raleway(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.normal,
          ),
          caption: GoogleFonts.raleway(
            color: Colors.grey[600],
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
          subtitle1: GoogleFonts.raleway(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
          subtitle2: GoogleFonts.raleway(
            color: Colors.black38,
            fontSize: 12,
            fontWeight: FontWeight.normal,
          )));

  static ThemeData darkTheme = ThemeData(
      fontFamily: 'RobotoCondensed',
      primaryColor: Color.fromRGBO(233, 75, 136, 1.0),
      backgroundColor: Color.fromRGBO(67, 67, 67, 1.0),
      splashColor: Colors.transparent,
      accentColor: Colors.grey[800],
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
        primary: Color.fromRGBO(233, 75, 136, 1.0),
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(20.0),
        ),
      )),
      textTheme: TextTheme(
          headline1: TextStyle(
              color: Colors.grey,
              fontSize: 45,
              fontWeight: FontWeight.bold,
              fontFamily: 'RobotoCondensed'),
          headline2: TextStyle(
              color: Colors.grey,
              fontSize: 35,
              fontWeight: FontWeight.bold,
              fontFamily: 'RobotoCondensed'),
          headline3: TextStyle(
              color: Colors.grey,
              fontSize: 30,
              fontWeight: FontWeight.bold,
              fontFamily: 'RobotoCondensed'),
          headline4: TextStyle(
              color: Colors.grey,
              fontSize: 25,
              fontWeight: FontWeight.bold,
              fontFamily: 'RobotoCondensed'),
          headline5: TextStyle(
              color: Colors.grey,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'RobotoCondensed'),
          headline6: TextStyle(
              color: Colors.grey,
              fontSize: 15,
              fontWeight: FontWeight.normal,
              fontFamily: 'RobotoCondensed'),
          subtitle1: TextStyle(
              color: Colors.grey,
              fontSize: 16,
              fontWeight: FontWeight.normal,
              fontFamily: 'RobotoCondensed'),
          caption: TextStyle(
              color: Colors.grey,
              fontSize: 14,
              fontWeight: FontWeight.normal,
              fontFamily: 'RobotoCondensed'),
          subtitle2: TextStyle(
              color: Colors.grey,
              fontSize: 12,
              fontWeight: FontWeight.normal,
              fontFamily: 'RobotoCondensed')));

  void switchTheme() {
    _isDark = !_isDark;
    notifyListeners();
  }

  ThemeData getMyTheme(bool _isDark) {
    return _isDark ? darkTheme : lightTheme;
  }
}
