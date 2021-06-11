import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:flutter_switch/flutter_switch.dart';

Widget switcher(
  BuildContext context,
  bool value,
  dynamic onChange, {
  String enableText = '',
  String disableText = '',
  Icon activeIcons = const Icon(Icons.check, color: Colors.grey),
  Icon inactiveIcons = const Icon(Icons.close, color: Colors.grey),
}) {
  FlutterSwitch swchIcon;

  if (enableText == '') {
    swchIcon = FlutterSwitch(
      width: 50.0,
      height: 25.0,
      toggleSize: 20.0,
      value: value,
      borderRadius: 30.0,
      showOnOff: false,
      padding: 2.0,
      activeToggleColor: Theme.of(context).primaryColor,
      inactiveToggleColor: Theme.of(context).primaryColor,
      activeSwitchBorder: Border.all(
        color: Theme.of(context).primaryColor,
        width: 1.0,
      ),
      inactiveSwitchBorder: Border.all(
        color: Theme.of(context).primaryColor,
        width: 1.0,
      ),
      activeColor: Theme.of(context).accentColor,
      inactiveColor: Theme.of(context).accentColor,
      activeIcon: activeIcons,
      inactiveIcon: inactiveIcons,
      onToggle: onChange,
    );
  } else {
    swchIcon = FlutterSwitch(
      width: 50.0,
      height: 25.0,
      toggleSize: 20.0,
      value: value,
      borderRadius: 30.0,
      padding: 2.0,
      activeText: enableText,
      inactiveText: disableText,
      showOnOff: true,
      activeTextFontWeight: FontWeight.w500,
      inactiveTextFontWeight: FontWeight.w500,
      activeTextColor: Theme.of(context).primaryColor,
      inactiveTextColor: Theme.of(context).primaryColor,
      activeToggleColor: Theme.of(context).primaryColor,
      inactiveToggleColor: Theme.of(context).primaryColor,
      activeSwitchBorder: Border.all(
        color: Theme.of(context).primaryColor,
        width: 1.0,
      ),
      inactiveSwitchBorder: Border.all(
        color: Theme.of(context).primaryColor,
        width: 1.0,
      ),
      activeColor: Theme.of(context).accentColor,
      inactiveColor: Theme.of(context).accentColor,
      onToggle: onChange,
    );
  }

  return swchIcon;
}
