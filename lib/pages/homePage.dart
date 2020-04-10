import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:moh_connect/utils/moh_drawer.dart';

class HomePage extends StatelessWidget {
  _switchPlatform(BuildContext context) {
    if (Platform.isAndroid) {
      PlatformProvider.of(context).changeToCupertinoPlatform();
    } else if (Platform.isIOS) {
      PlatformProvider.of(context).changeToMaterialPlatform();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: PlatformText('Home'),
      ),
      body: Center(
        child: PlatformButton(
          child: PlatformText('Switch Platform'),
          onPressed: () => _switchPlatform(context),
        ),
      ),
      android: (_) => MaterialScaffoldData(
        drawer: MoHConnectDrawer(),
      ),
      ios: (_) => CupertinoPageScaffoldData(
        bottomTabBar: CupertinoTabBar(items: []),
      ),
    );
  }
}
