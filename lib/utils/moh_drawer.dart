import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MoHConnectDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(children: [
        ListTile(
          leading: Icon(Icons.home),
          title: Text('Home'),
          onTap: () {
            Navigator.pop(context);

            Navigator.pushNamed(context, 'HomePage');
          },
        ),
        ListTile(
          leading: Icon(Icons.edit),
          title: Text('Register'),
          onTap: () {
            Navigator.pop(context);

            Navigator.pushNamed(context, 'RegisterPage');
          },
        ),
        ListTile(
          leading: Icon(Icons.lock_open),
          title: Text('Login'),
          onTap: () {
            Navigator.pop(context);

            Navigator.pushNamed(context, 'LoginPage');
          },
        ),
        ListTile(
          leading: Icon(Icons.announcement),
          title: Text('Report'),
          onTap: () {
            Navigator.pop(context);

            Navigator.pushNamed(context, 'ReportPage');
          },
        ),
        ListTile(
          leading: Icon(Icons.contacts),
          title: Text('Contacts'),
          onTap: () {
            Navigator.pop(context);

            Navigator.pushNamed(context, 'ContactPage');
          },
        ),
        ListTile(
          leading: Icon(Icons.more_horiz),
          title: Text('Symptoms'),
          onTap: () {
            Navigator.pop(context);

            Navigator.pushNamed(context, 'SymptomsPage');
          },
        ),
        ListTile(
          leading: Icon(Icons.exit_to_app),
          title: Text('Exit Application'),
          onTap: () =>
              SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
        ),
      ]),
    );
  }
}
