import 'package:flutter/material.dart';
import 'package:moh_connect/pages/contactsPage.dart';
import 'package:moh_connect/pages/homePage.dart';
import 'package:moh_connect/pages/loginPage.dart';
import 'package:moh_connect/pages/registerPage.dart';
import 'package:moh_connect/pages/home/reportPage.dart';
import 'package:moh_connect/pages/symptomsPage.dart';

const String initRoute = 'HomePage';
const String reportRoute = 'ReportPage';
const String contactsRoute = 'ContactPage';
const String registerRoute = 'RegisterPage';
const String symptomsRoute = 'SymptomsPage';
const String loginRoute = 'LoginPage';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initRoute:
        return MaterialPageRoute(
            builder: (_) => HomePage(),
            settings: RouteSettings(name: initRoute));
      case reportRoute:
        return MaterialPageRoute(
            builder: (_) => ReportPage(),
            settings: RouteSettings(name: reportRoute));
      case contactsRoute:
        return MaterialPageRoute(
            builder: (_) => ContactsPage(),
            settings: RouteSettings(name: contactsRoute));
      case registerRoute:
        return MaterialPageRoute(
            builder: (_) => RegisterPage(),
            settings: RouteSettings(name: registerRoute));
        break;
      case symptomsRoute:
        return MaterialPageRoute(
            builder: (_) => SymptomsPage(),
            settings: RouteSettings(name: symptomsRoute));
        break;
      case loginRoute:
        return MaterialPageRoute(
            builder: (_) => LoginPage(),
            settings: RouteSettings(name: loginRoute));
        break;
      default:
        return MaterialPageRoute(
            builder: (_) => Container(),
            settings: RouteSettings(name: 'Error Page'));
    }
  }
}
