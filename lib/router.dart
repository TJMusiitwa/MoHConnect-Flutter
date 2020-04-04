import 'package:flutter/material.dart';
import 'package:moh_connect/pages/contactsPage.dart';
import 'package:moh_connect/pages/homePage.dart';
import 'package:moh_connect/pages/registerPage.dart';
import 'package:moh_connect/pages/reportPage.dart';

const String initRoute = 'HomePage';
const String reportRoute = 'ReportPage';
const String contactsRoute = 'ContactPage';
const String registerRoute = 'RegisterPage';

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
      default:
        return MaterialPageRoute(
            builder: (_) => null, settings: RouteSettings(name: 'Error Page'));
    }
  }
}
