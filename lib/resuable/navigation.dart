import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

class BottomNav extends StatefulWidget {
  final int initPage;

  const BottomNav(this.initPage);

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    print(widget.initPage);
    this._selectedIndex = widget.initPage;
  }

  List<BottomNavyBarItem> navItems(context) => [
        BottomNavyBarItem(
            icon: Icon(Icons.tv),
            title: Text('Channels'),
            activeColor: Theme.of(context).primaryColor),
        BottomNavyBarItem(
            icon: Icon(Icons.map_outlined),
            title: Text('Regions'),
            activeColor: Theme.of(context).primaryColor),
        BottomNavyBarItem(
            icon: Icon(Icons.favorite_border_outlined),
            title: Text('Favourites'),
            activeColor: Theme.of(context).primaryColor),
      ];

  void navigationPage(page) {
    Navigator.of(context).pushReplacementNamed('/$page');
  }

  changeNav(int value) {
    setState(() {
      _selectedIndex = value;
    });
    switch (value) {
      case 0:
        navigationPage('channels');
        break;
      case 1:
        navigationPage('region');
        break;
      case 2:
        navigationPage('favourites');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: BottomNavyBar(
        selectedIndex: _selectedIndex,
        showElevation: true,
        items: navItems(context),
        onItemSelected: changeNav,
      ),
    );
  }
}
