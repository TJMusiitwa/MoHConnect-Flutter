import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:moh_connect/pages/home/selfAssessmentPage.dart';
import 'package:moh_connect/pages/home/reportPage.dart';
import 'package:moh_connect/widgets/stat_card.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HasuraConnect connect = HasuraConnect('https://covid19-graphql.now.sh/');
  static DateTime currentBackPressTime;

  final String countryStat = """
  query uganda {
  country(name: "Uganda") {
    mostRecent {
      confirmed
      deaths
      recovered
      growthRate
      date
    }
  }
}
  """;
  final String countryTimeline = """
  query ugTimeSeries {
  results(countries: ["Uganda"], date: { gt: "3/20/2020" }) {
    date
    confirmed
    deaths
    recovered
    growthRate
  }
}


""";
  var cache;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        DateTime now = DateTime.now();
        if (currentBackPressTime == null ||
            now.difference(currentBackPressTime) > Duration(seconds: 2)) {
          currentBackPressTime = now;
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('Tap again to close app'),
          ));
          return Future.value(false);
        }
        return Future.value(true);
      },
      child: PlatformScaffold(
        appBar: PlatformAppBar(
          title: PlatformText('Home'),
          ios: (_) => CupertinoNavigationBarData(
              trailing: PlatformIconButton(
            iosIcon: Icon(CupertinoIcons.phone),
            onPressed: () {
              var phone = 'tel:0800100066';
              launch(phone);
            },
          )),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              FutureBuilder(
                //initialData: cache,
                future: getCountryData(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  //cache = snapshot.data.value['data']['country']['mostRecent'];
                  final stat =
                      snapshot.data.value['data']['country']['mostRecent'];
                  if (snapshot.connectionState == ConnectionState.waiting &&
                      snapshot.hasData == true) {
                    return PlatformCircularProgressIndicator();
                  }

                  if (snapshot.hasError) {
                    return Text(snapshot.error);
                  }

                  if (snapshot.connectionState == ConnectionState.none &&
                      snapshot.hasData == null) {
                    return Container(
                      child: Text('No data available to show'),
                    );
                  }

                  return Column(
                    children: <Widget>[
                      ConstrainedBox(
                        constraints: BoxConstraints(maxHeight: 120),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              StatCard(
                                  title: 'Confirmed',
                                  statCount: Text(stat['confirmed'].toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue,
                                          ))),
                              StatCard(
                                  title: 'Recovered',
                                  statCount: Text(stat['recovered'].toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline
                                          .copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green))),
                              StatCard(
                                  title: 'Deaths',
                                  statCount: Text(stat['deaths'].toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline
                                          .copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red))),
                            ]),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Spacer(),
                          PlatformText('Last Updated : ' + stat['date'])
                        ],
                      ),
                    ],
                  );
                },
              ),
              SizedBox(height: 20),
              Container(
                color: Colors.orange,
                height: 280,
                child: Center(child: Text('Graph will be added here')),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      platformPageRoute(
                          context: context,
                          builder: (_) => SelfAssessmentPage()));
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    title: Text('Self-Assessment Tool'),
                    subtitle:
                        Text('Use this tool to determine if you have COVID-19'),
                    trailing: Icon(context.platformIcons.rightChevron),
                  ),
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      platformPageRoute(
                          context: context, builder: (_) => ReportPage()));
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    title: Text('Report a case'),
                    subtitle: Text(
                        'Recently been in contact with a patient? Report here!'),
                    trailing: Icon(context.platformIcons.rightChevron),
                  ),
                ),
              )
            ],
          ),
        ),
        android: (_) => MaterialScaffoldData(
          //drawer: MoHConnectDrawer(),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.phone),
            tooltip: 'Covid-19 helpline',
            onPressed: () {
              var phone = 'tel:0800100066';
              launch(phone);
            },
          ),
        ),
        iosContentPadding: true,
      ),
    );
  }

  Future getCountryData() async {
    var r = connect.cachedQuery(countryStat);
    return r;
  }

  Future getCountryTimeline() async {
    var timeline = connect.cachedQuery(countryTimeline);
    return timeline;
  }

  @override
  void initState() {
    super.initState();
    getCountryData();
    getCountryTimeline();
  }
}
