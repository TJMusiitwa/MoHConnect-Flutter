import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: PlatformText('About'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text('MoH Connect'),

            Text(
              'MoH Connect is an initiative from the Ministry of Health of Uganda to provide awareness on the Coronavirus disease(COVID-19), There are several features including a self-asssessment test, reporting tool, statistics of the current cases in the country(updated daily)',
              softWrap: true,
              textAlign: TextAlign.justify,
            ),
            //SizedBox(height: 15),

            ListTile(
              title: Text('Email us your feedback'),
              onTap: () async {
                var emailUrl =
                    'mailto:info@health.go.ug?subject=MoH Connect&body=Hello, I would like to submit feedback about your app.';
                var out = Uri.encodeFull(emailUrl);
                await launch(out);
              },
            ),
            ListTile(
              title: Text('Coronavirus Data Provider'),
              subtitle: Text(
                  'Coronavirus data for Uganda  is sourced from https://covid19-graphql.now.sh/'),
            ),

            ListTile(
              title: Text('Ministry of Health Twitter - @MinofHealthUG'),
              subtitle: Text(
                  'You can access the latest reports from the official Twitter account for the Ministry of Health'),
              onTap: () async =>
                  await launch('https://www.twitter.com/MinofHealthUG?s=09'),
            ),

            ListTile(
              title: Text('Safety Measures'),
              subtitle: Text(
                  'For more information on safety measures and symptoms,please visit https://health.go.ug'),
              onTap: () async => await launch('https://health.go.ug',
                  forceSafariVC: true,
                  forceWebView: true,
                  enableJavaScript: true),
            ),

            PlatformButton(
              child: Text('Switch Platforms'),
              onPressed: () => _switchPlatform(context),
            ),
          ],
        ),
      ),
    );
  }

  _switchPlatform(BuildContext context) {
    if (Platform.isAndroid) {
      PlatformProvider.of(context).changeToCupertinoPlatform();
    } else if (Platform.isIOS) {
      PlatformProvider.of(context).changeToMaterialPlatform();
    }
  }
}
