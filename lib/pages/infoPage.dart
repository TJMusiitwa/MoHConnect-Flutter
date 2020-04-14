import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:moh_connect/pages/contactsPage.dart';

class InfoPage extends StatefulWidget {
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final Map<int, Widget> infoTitles = const <int, Widget>{
    0: Text('Q & A'),
    1: Text('Advice for Public'),
    2: Text('Contacts'),
  };

  final Map<int, Widget> iOSInfoContent = const <int, Widget>{
    0: Center(
      child: FlutterLogo(
        colors: Colors.indigo,
        size: 200.0,
      ),
    ),
    1: Center(
      child: FlutterLogo(
        colors: Colors.teal,
        size: 200.0,
      ),
    ),
    2: ContactsPage()
  };

  int _selectedIndexValue = 0;

  TabController tabController;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text('Info'),
        automaticallyImplyLeading: false,
      ),
      android: (_) => MaterialScaffoldData(
          appBar: AppBar(
            bottom: TabBar(controller: tabController, tabs: [
              Tab(
                icon: Icon(Icons.help_outline),
                text: 'Q & A',
              ),
              Tab(
                icon: Icon(Icons.question_answer),
                text: 'Advice for public',
              ),
              Tab(
                icon: Icon(Icons.phone),
                text: 'Contacts',
              ),
            ]),
          ),
          body: TabBarView(controller: tabController, children: [
            Container(),
            Container(),
            ContactsPage(),
          ])),
      ios: (_) => CupertinoPageScaffoldData(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 500,
                    child: CupertinoSegmentedControl(
                        children: infoTitles,
                        groupValue: _selectedIndexValue,
                        onValueChanged: (value) {
                          setState(() {
                            _selectedIndexValue = value;
                          });
                        }),
                  ),
                  Expanded(child: iOSInfoContent[_selectedIndexValue])
                ]),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    tabController = new TabController(length: 3, vsync: this);
    super.initState();
  }
}
