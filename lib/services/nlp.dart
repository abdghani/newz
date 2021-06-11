import 'package:google_ml_kit/google_ml_kit.dart';

getLanguage(String txt) async {
  final languageIdentifier = GoogleMlKit.nlp.languageIdentifier();
  return await languageIdentifier.identifyLanguage(txt);
}
