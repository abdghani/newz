import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AppLoader extends StatelessWidget {
  final String loadingText;

  AppLoader(this.loadingText);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SpinKitCircle(
          color: Theme.of(context).primaryColor,
          size: 50.0,
        ),
        SizedBox(height: 10),
        Text(
          loadingText,
          style: Theme.of(context).textTheme.headline6,
        ),
      ],
    );
  }
}
