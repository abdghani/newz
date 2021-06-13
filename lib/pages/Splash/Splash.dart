import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:newz/util/preferences.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var prefProvider = Provider.of<PrefProvider>(context, listen: false);
    prefProvider.setInitialPreferences();

    void navigationPage(page) {
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.of(context).pushReplacementNamed('/$page');
      });
    }

    navigationPage('news');

    Widget splashContent = Center(
      child: Align(
        alignment: Alignment.center,
        child: Image.asset(
          "assets/images/app-icon.png",
          height: 150,
        ),
      ),
    );

    return Container(
      color: Theme.of(context).backgroundColor,
      child: splashContent,
    );
  }
}
