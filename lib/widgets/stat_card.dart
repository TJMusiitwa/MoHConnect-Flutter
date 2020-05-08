import 'package:flutter/material.dart';

class StatCard extends StatelessWidget {
  final String title;
  final Widget statCount;

  const StatCard({Key key, this.title, this.statCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 4,
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(title, style: Theme.of(context).textTheme.subtitle1),
                SizedBox(height: 8),
                statCount,
              ],
            ),
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            width: 100,
            height: 100,
          ),
        ),
      ],
    );
  }
}
