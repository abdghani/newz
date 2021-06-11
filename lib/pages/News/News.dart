import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newz/pages/News/tabs/Category.dart';
import 'package:newz/pages/News/tabs/Channels.dart';
import 'package:newz/pages/News/tabs/Region.dart';
import 'package:newz/pages/News/tabs/Settings.dart';

class NewsContainer extends StatefulWidget {
  @override
  _NewsContainerState createState() => _NewsContainerState();
}

class _NewsContainerState extends State<NewsContainer> {
  int _pageIndex = 0;
  late PageController _pageController;

  List<Widget> tabPages = [Categories(), Channels(), Region(), Settings()];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _pageIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void onPageChanged(int page) {
    if (page != _pageIndex) {
      setState(() {
        this._pageIndex = page;
      });
      this._pageController.jumpToPage(page);
    }
  }

  void onTabTapped(int index) {}

  changeNav(int value) {
    setState(() {
      _pageIndex = value;
    });
  }

  List<BottomNavyBarItem> navItems(context) => [
        BottomNavyBarItem(
            textAlign: TextAlign.center,
            icon: Icon(Icons.category_outlined),
            title: Text(
              'CATEGORY',
              style: GoogleFonts.raleway(
                  fontSize: 14, fontWeight: FontWeight.bold),
            ),
            activeColor: Theme.of(context).primaryColor),
        BottomNavyBarItem(
            textAlign: TextAlign.center,
            icon: Icon(Icons.tv),
            title: Text(
              'CHANNELS',
              style: GoogleFonts.raleway(
                  fontSize: 14, fontWeight: FontWeight.bold),
            ),
            activeColor: Theme.of(context).primaryColor),
        BottomNavyBarItem(
            textAlign: TextAlign.center,
            icon: Icon(Icons.map_outlined),
            title: Text(
              'REGIONS',
              style: GoogleFonts.raleway(
                  fontSize: 14, fontWeight: FontWeight.bold),
            ),
            activeColor: Theme.of(context).primaryColor),
        BottomNavyBarItem(
            textAlign: TextAlign.center,
            icon: Icon(Icons.settings),
            title: Text(
              'SETTINGS',
              style: GoogleFonts.raleway(
                  fontSize: 14, fontWeight: FontWeight.bold),
            ),
            activeColor: Theme.of(context).primaryColor)
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      bottomNavigationBar: Container(
        child: BottomNavyBar(
          showElevation: false,
          mainAxisAlignment: MainAxisAlignment.center,
          containerHeight: 50,
          selectedIndex: _pageIndex,
          items: navItems(context),
          backgroundColor: Theme.of(context).backgroundColor,
          onItemSelected: onPageChanged,
        ),
      ),
      body: PageView(
          children: tabPages,
          controller: _pageController,
          onPageChanged: (value) {
            if (_pageIndex != value) {
              this.setState(() {
                _pageIndex = value;
              });
            }
          }),
    );
  }
}
