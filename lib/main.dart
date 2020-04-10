import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moh_connect/router.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:moh_connect/utils/moh_tabbar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final materialTheme = new ThemeData(
      primarySwatch: Colors.purple,
    );
    final materialDarkTheme = new ThemeData(
      brightness: Brightness.dark,
      primarySwatch: Colors.teal,
    );

    final cupertinoTheme = new CupertinoThemeData(
      primaryColor: CupertinoDynamicColor.withBrightness(
        color: Colors.purple,
        darkColor: Colors.cyan,
      ),
    );
    return PlatformProvider(
      builder: (BuildContext context) => PlatformApp(
        title: 'MoH Connect',
        android: (_) => MaterialAppData(
          theme: materialTheme,
          darkTheme: materialDarkTheme,
          onGenerateRoute: Router.generateRoute,
          initialRoute: initRoute,
        ),
        ios: (_) => CupertinoAppData(theme: cupertinoTheme, home: MohTabBar()),
      ),
    );
  }
}
