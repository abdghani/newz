import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
    fontFamily: 'RobotoCondensed',
    primaryColor: Color.fromRGBO(233, 75, 136, 1.0),
    accentColor: Color.fromRGBO(247, 247, 247, 1.0),
    backgroundColor: Color.fromRGBO(254, 254, 254, 1.0),
    textTheme: TextTheme(
        headline1: TextStyle(
            color: Colors.black,
            fontSize: 45,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoCondensed'),
        headline2: TextStyle(
            color: Colors.black,
            fontSize: 35,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoCondensed'),
        headline3: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoCondensed'),
        headline4: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoCondensed'),
        headline5: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoCondensed'),
        headline6: TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.normal,
            fontFamily: 'RobotoCondensed'),
        caption: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
            fontWeight: FontWeight.normal,
            fontFamily: 'RobotoCondensed'),
        subtitle1: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.normal,
            fontFamily: 'RobotoCondensed'),
        subtitle2: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.normal,
            fontFamily: 'RobotoCondensed')));

ThemeData darkTheme = ThemeData(
    fontFamily: 'RobotoCondensed',
    primaryColor: Color.fromRGBO(233, 75, 136, 1.0),
    backgroundColor: Color.fromRGBO(67, 67, 67, 1.0),
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
            color: Colors.white,
            fontSize: 45,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoCondensed'),
        headline2: TextStyle(
            color: Colors.white,
            fontSize: 35,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoCondensed'),
        headline3: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoCondensed'),
        headline4: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoCondensed'),
        headline5: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoCondensed'),
        headline6: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.normal,
            fontFamily: 'RobotoCondensed'),
        subtitle1: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.normal,
            fontFamily: 'RobotoCondensed'),
        caption: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.normal,
            fontFamily: 'RobotoCondensed'),
        subtitle2: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.normal,
            fontFamily: 'RobotoCondensed')));
