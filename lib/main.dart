import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newz/pages/News/News.dart';
import 'package:newz/pages/News/bloc/channels_bloc.dart';
import 'package:newz/pages/Splash/Splash.dart';
import 'package:newz/themes/theme.dart';
import 'package:newz/util/preferences.dart';
import 'package:provider/provider.dart';
import 'package:newz/themes/dark_theme_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = new DarkThemeProvider();
  final _messangerKey = GlobalKey<ScaffoldMessengerState>();

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreference.getTheme();
  }

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (BuildContext context) => themeChangeProvider,
          ),
          ChangeNotifierProvider(
              create: (BuildContext context) => PrefProvider()),
          BlocProvider(
            create: (context) => ChannelsBloc(),
          ),
        ],
        child: Consumer<DarkThemeProvider>(
          builder: (BuildContext context, value, Widget? child) {
            return MaterialApp(
                scaffoldMessengerKey: _messangerKey,
                debugShowCheckedModeBanner: false,
                title: 'Vantage',
                routes: {
                  '/news': (context) => NewsContainer(),
                },
                theme: MyThemes().getMyTheme(themeChangeProvider.darkTheme),
                home: SplashScreen());
          },
        ));
  }
}
