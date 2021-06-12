import 'package:flutter/material.dart';
import 'package:newz/resuable/switcher.dart';
import 'package:newz/util/preferences.dart';
import 'package:provider/provider.dart';
import 'package:newz/themes/dark_theme_provider.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  dynamic appPrefs;

  static const Icon activeThemeIcons =
      Icon(Icons.nightlight_round, color: Colors.white70);
  static const Icon inActiveThemeIcons =
      Icon(Icons.wb_sunny, color: Colors.white70);

  changeDefaultEnglish(value) {
    setState(() {
      appPrefs['defaultEnglish'] = value;
    });
    var prefProvider = Provider.of<PrefProvider>(context, listen: false);
    prefProvider.setAppPreferences(appPrefs);
  }

  setInitialPreferences() async {
    var prefProvider = Provider.of<PrefProvider>(context, listen: false);
    dynamic prefs = prefProvider.prefs;
    setState(() {
      appPrefs = prefs;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setInitialPreferences();
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    onThemeChange(value) {
      themeChange.darkTheme = value;
    }

    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 50, left: 20, right: 20),
        color: Theme.of(context).backgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Settings',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Theme',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Text(
                      'Dark/Light theme',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ],
                ),
                Spacer(),
                switcher(context, themeChange.darkTheme, onThemeChange,
                    activeIcons: activeThemeIcons,
                    inactiveIcons: inActiveThemeIcons)
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'English News',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Text(
                      appPrefs['defaultEnglish'] == true
                          ? 'Show only english news'
                          : 'Showing news from all language',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ],
                ),
                Spacer(),
                switcher(
                    context, appPrefs['defaultEnglish'], changeDefaultEnglish,
                    enableText: '', disableText: '')
              ],
            ),
          ],
        ),
      ),
    );
  }
}
