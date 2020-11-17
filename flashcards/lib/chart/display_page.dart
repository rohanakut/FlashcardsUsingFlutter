import 'package:flashcards/chart/today_progress.dart';
import 'package:flashcards/chart/today_progress_chart.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class DisplayPage extends StatelessWidget {
  final List<TodayProgress> data = [
    TodayProgress(
        type: "bad",
        numCards: 15,
        barColor: charts.ColorUtil.fromDartColor(Colors.teal[200])),
    TodayProgress(
      type: "ok",
      numCards: 10,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue[200]),
    ),
    TodayProgress(
        type: "good",
        numCards: 5,
        barColor: charts.ColorUtil.fromDartColor(Colors.orange[200])),
  ];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text("Review")),
        body: Column(
          children: <Widget>[
            Row(
              children: <Widget>[Text("Number of cards reviewed"), Text("30")],
            ),
            TodayProgressChart(data)
          ],
        ));
  }
}
