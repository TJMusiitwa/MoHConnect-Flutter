import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:moh_connect/pages/reportPage.dart';
import 'package:moh_connect/utils/moh_drawer.dart';
import 'package:moh_connect/widgets/stat_card.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HasuraConnect connect = HasuraConnect('https://covid19-graphql.now.sh/');

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
  results(countries: ["Uganda"], date: { gt: "2/22/2020" }) {
    date
    confirmed
    deaths
    recovered
    growthRate
  }
}


""";
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: PlatformText('Home'),
        ios: (_) => CupertinoNavigationBarData(
            trailing: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      CupertinoPageRoute(builder: (_) => ReportPage()));
                },
                child: Icon(
                  CupertinoIcons.pen,
                  size: 25,
                ))),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FutureBuilder(
              future: getCountryData(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                final stat =
                    snapshot.data.value['data']['country']['mostRecent'];
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return PlatformCircularProgressIndicator();
                }

                if (snapshot.hasError) {
                  return Text(snapshot.error);
                }

                if (snapshot.connectionState == ConnectionState.none &&
                    snapshot.hasData == null) {
                  return Container();
                }
                return Column(
                  children: <Widget>[
                    ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: 120),
                      child: Row(children: [
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
            )
          ],
        ),
      ),
      android: (_) => MaterialScaffoldData(
        drawer: MoHConnectDrawer(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
                context,
                platformPageRoute(
                    builder: (_) => ReportPage(),
                    context: context,
                    iosTitle: 'Report an Issue'));
          },
          label: Text('Report an issue'),
        ),
      ),
      iosContentPadding: true,
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
