import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newz/pages/Home/bloc/news_bloc.dart';
import 'package:newz/pages/Home/home.dart';
import 'package:newz/util/theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        theme: lightTheme,
        home: Scaffold(
          body: SafeArea(
            child: MultiBlocProvider(providers: [
              BlocProvider(
                create: (context) => NewsBloc(),
              ),
            ], child: Home()),
          ),
        ));
  }
}
