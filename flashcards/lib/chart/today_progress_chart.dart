import 'package:flashcards/chart/today_progress.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class TodayProgressChart extends StatelessWidget {
  List<TodayProgress> data;

  TodayProgressChart(this.data);
  @override
  Widget build(BuildContext context) {
    List<charts.Series<TodayProgress, String>> series = [
      charts.Series(
          id: "Today's Progress",
          data: data,
          domainFn: (TodayProgress series, _) => series.type,
          measureFn: (TodayProgress series, _) => series.numCards,
          colorFn: (TodayProgress series, _) => series.barColor)
    ];
    return Container(
      height: 400,
      padding: EdgeInsets.all(20),
      child: Card(
        child: Column(
          children: <Widget>[
            Text("Today's Progress"),
            Expanded(
              child: charts.BarChart(series, animate: true),
            )
          ],
        ),
      ),
    );
    // TODO: implement build
  }
}
