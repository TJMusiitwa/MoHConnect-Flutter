import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key key}) : super(key: key);

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
        title: PlatformText('About'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10),
        child: Column(
          children: <Widget>[
            ListTile(),
            PlatformButton(
              child: Text('Switch Platforms'),
              onPressed: () => _switchPlatform(context),
            ),
          ],
        ),
      ),
    );
  }
}
