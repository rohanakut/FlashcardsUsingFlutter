import 'package:flashcards/chart/daily_progress.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class DailyProgressChart extends StatelessWidget {
  List<DailyProgress> data;

  DailyProgressChart(this.data);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    List<charts.Series<DailyProgress, int>> series = [
      charts.Series(
        id: "Today's Progress",
        data: data,
        domainFn: (DailyProgress series, _) => series.day,
        measureFn: (DailyProgress series, _) => series.confidence,
      )
    ];

    return Container(
      height: 400,
      padding: EdgeInsets.all(20),
      child: Card(
        child: Column(
          children: <Widget>[
            Text("Today's Progress"),
            Expanded(
              child: charts.LineChart(series,
                  animate: true,
                  defaultRenderer:
                      new charts.LineRendererConfig(includePoints: true)),
            )
          ],
        ),
      ),
    );
  }
}
