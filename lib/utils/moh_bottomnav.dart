import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:moh_connect/pages/about/aboutPage.dart';
import 'package:moh_connect/pages/homePage.dart';
import 'package:moh_connect/pages/infoPage.dart';

class MohBottomNav extends StatefulWidget {
  @override
  _MohBottomNavState createState() => _MohBottomNavState();
}

class _MohBottomNavState extends State<MohBottomNav> {
  int _currentPage = 0;

  var pages = [
    HomePage(),
    InfoPage(),
    AboutPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      body: Container(
        child: pages.elementAt(_currentPage),
      ),
      bottomNavBar: PlatformNavBar(
          currentIndex: _currentPage,
          items: [
            BottomNavigationBarItem(
              icon: Icon(context.platformIcons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(context.platformIcons.info),
              title: Text('Info'),
            ),
            BottomNavigationBarItem(
              icon: Icon(context.platformIcons.settings),
              title: Text('About'),
            ),
          ],
          itemChanged: (index) {
            setState(() {
              _currentPage = index;
            });
          }),
    );
  }
}
