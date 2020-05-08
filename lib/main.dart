import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:moh_connect/utils/moh_bottomnav.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final materialTheme = new ThemeData(
      primarySwatch: Colors.amber,
    );
    final materialDarkTheme = new ThemeData(
      brightness: Brightness.dark,
      primarySwatch: Colors.red,
    );

    final cupertinoTheme = new CupertinoThemeData(
        primaryColor: CupertinoDynamicColor.withBrightness(
          color: CupertinoColors.systemOrange,
          darkColor: CupertinoColors.systemRed,
        ),
        textTheme: CupertinoTextThemeData(
          primaryColor: CupertinoDynamicColor.withBrightness(
            color: Color.fromARGB(255, 0, 0, 0),
            darkColor: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        scaffoldBackgroundColor: CupertinoDynamicColor.withBrightness(
          color: CupertinoColors.white,
          darkColor: CupertinoColors.black,
        ));

    return PlatformProvider(
      settings: PlatformSettingsData(iosUsesMaterialWidgets: true),
      builder: (BuildContext context) => PlatformApp(
        title: 'MoH Connect',
        localizationsDelegates: <LocalizationsDelegate<dynamic>>[
          DefaultMaterialLocalizations.delegate,
          DefaultWidgetsLocalizations.delegate,
          DefaultCupertinoLocalizations.delegate,
        ],
        android: (_) => MaterialAppData(
          theme: materialTheme,
          darkTheme: materialDarkTheme,
          // onGenerateRoute: Router.generateRoute,
          // initialRoute: initRoute,
        ),
        ios: (_) => CupertinoAppData(
          theme: cupertinoTheme,
          //home: MohTabBar()
        ),
        home: MohBottomNav(),
      ),
    );
  }
}
