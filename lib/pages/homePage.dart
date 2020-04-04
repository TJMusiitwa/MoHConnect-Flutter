import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:moh_connect/utils/moh_drawer.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: PlatformText('Home'),
      ),
      body: Container(),
      android: (_) => MaterialScaffoldData(
        drawer: MoHConnectDrawer(),
      ),
      ios: (_) => CupertinoPageScaffoldData(
        bottomTabBar: CupertinoTabBar(items: []),
      ),
    );
  }
}
