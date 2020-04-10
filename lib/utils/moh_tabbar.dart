import 'package:flutter/cupertino.dart';
import 'package:moh_connect/pages/contactsPage.dart';
import 'package:moh_connect/pages/reportPage.dart';
import 'package:moh_connect/pages/symptomsPage.dart';

class MohTabBar extends StatefulWidget {
  @override
  _MohTabBarState createState() => _MohTabBarState();
}

class _MohTabBarState extends State<MohTabBar> {
  int _currentTab = 0;
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home), title: Text('Home')),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.phone), title: Text('Contacts')),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.info), title: Text('Symptoms')),
        ],
        currentIndex: _currentTab,
        onTap: (int newTab) {
          setState(() {
            _currentTab = newTab;
          });
        },
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return CupertinoTabView(
              defaultTitle: 'Report',
              builder: (context) {
                return CupertinoPageScaffold(child: ReportPage());
              },
            );
            break;
          case 1:
            return CupertinoTabView(
              defaultTitle: 'Contacts',
              builder: (context) {
                return CupertinoPageScaffold(child: ContactsPage());
              },
            );
            break;
          case 2:
            return CupertinoTabView(
              defaultTitle: 'Symptoms',
              builder: (context) {
                return CupertinoPageScaffold(child: SymptomsPage());
              },
            );
            break;
          default:
            return ReportPage();
            break;
        }
      },
    );
  }
}
