import 'package:flashcards/chart/daily_progress.dart';
import 'package:flashcards/chart/daily_progress_chart.dart';
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

  final List<DailyProgress> data1 = [
    DailyProgress(day: 1, confidence: 50),
    DailyProgress(day: 2, confidence: 50),
    DailyProgress(day: 3, confidence: 60),
    DailyProgress(day: 4, confidence: 30),
    DailyProgress(day: 5, confidence: 80),
    DailyProgress(day: 6, confidence: 100),
    DailyProgress(day: 7, confidence: 90),
    DailyProgress(day: 8, confidence: 100),
    DailyProgress(day: 9, confidence: 100),
    DailyProgress(day: 10, confidence: 100)
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text("Review")),
        body: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[Text("Number of cards reviewed"), Text("30")],
            ),
            TodayProgressChart(data),
            DailyProgressChart(data1)
          ],
        )));
  }
}
