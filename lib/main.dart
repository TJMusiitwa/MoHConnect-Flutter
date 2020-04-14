import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:moh_connect/utils/moh_bottomnav.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
        color: CupertinoColors.systemRed,
        darkColor: CupertinoColors.systemRed,
      ),
    );
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
