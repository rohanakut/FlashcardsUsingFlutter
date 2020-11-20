import 'package:flashcards/chart/daily_progress.dart';
import 'package:flashcards/chart/daily_progress_chart.dart';
import 'package:flashcards/chart/today_progress.dart';
import 'package:flashcards/chart/today_progress_chart.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flashcards/database/connection/database_helper.dart';
import 'package:flashcards/database/models/chart.dart';

class DisplayPage extends StatefulWidget {
  int _deckNum, _id;
  DisplayPage(this._deckNum, this._id);
  DisplayPageState createState() =>
      new DisplayPageState(this._deckNum, this._id);
}

class DisplayPageState extends State<DisplayPage> {
  int _deckNum, _id;
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Chart> chartList;
  // List<FlSpot> _listAdd = [];
  List<double> _percentage = [];
  List<int> _good = [];
  List<int> _ok = [];
  List<int> _bad = [];
  int _goodNum, _badNum, _okNum;
  List<TodayProgress> data;
  List<double> _percentageToDisplay;
  DisplayPageState(this._deckNum, this._id);

  Future<List<Chart>> _getData() async {
    chartList = await databaseHelper.getChartList(_deckNum, _id);
    print("length is ${chartList.length}");
    chartList.map((item) => _percentage.insert(0, item.percentage)).toList();
    chartList.map((item) => _good.insert(0, item.good)).toList();
    chartList.map((item) => _ok.insert(0, item.ok)).toList();
    chartList.map((item) => _bad.insert(0, item.bad)).toList();
  }

  // List<FlSpot> _generate() {
  //   _getData().then((value) {
  //     print(_percentage);
  //     if (_percentage.length < 10) {
  //       print("percentage is $_percentage");
  //       for (int i = _percentage.length - 1; i >= 0; i--) {
  //         _listAdd.insert(0, FlSpot(i.toDouble(), _percentage[i]));
  //       }
  //     } else if (_percentage.length >= 10) {
  //       int j = 0;
  //       for (int i = 0; i < 11; i++) {
  //         _listAdd.insert(0, FlSpot(i.toDouble(), _percentage[i]));
  //         j++;
  //       }
  //     }
  //   });
  //   print(_listAdd);
  //   _listAdd = _listAdd.reversed.toList();
  //   return _listAdd;
  // }
  @override
  void initState() {
    super.initState();
    _getData().then((value) {
      _goodNum = _good[0];
      _okNum = _ok[0];
      _badNum = _bad[0];
      // if (_percentage.length < 10) {
      //   print("percentage is $_percentage");
      //   for (int i = _percentage.length - 1; i >= 0; i--) {
      //     _listAdd.insert(0, FlSpot(i.toDouble(), _percentage[i]));
      //   }
      // } else if (_percentage.length >= 10) {
      //   int j = 0;
      //   for (int i = 0; i < 11; i++) {
      //     _listAdd.insert(0, FlSpot(i.toDouble(), _percentage[i]));
      //     j++;
      //   }
      // }
      // _listAdd = _listAdd.reversed.toList();

      data = [
        TodayProgress(
            type: "bad",
            numCards: _badNum,
            barColor: charts.ColorUtil.fromDartColor(Colors.teal[200])),
        TodayProgress(
          type: "ok",
          numCards: _okNum,
          barColor: charts.ColorUtil.fromDartColor(Colors.blue[200]),
        ),
        TodayProgress(
            type: "good",
            numCards: _goodNum,
            barColor: charts.ColorUtil.fromDartColor(Colors.orange[200])),
      ];

      setState(() {});
    });

    // TODO: implement initState
    ;
  }

  // final List<TodayProgress> data = [
  //   TodayProgress(
  //       type: "bad",
  //       numCards: _badNum,
  //       barColor: charts.ColorUtil.fromDartColor(Colors.teal[200])),
  //   TodayProgress(
  //     type: "ok",
  //     numCards: 10,
  //     barColor: charts.ColorUtil.fromDartColor(Colors.blue[200]),
  //   ),
  //   TodayProgress(
  //       type: "good",
  //       numCards: 5,
  //       barColor: charts.ColorUtil.fromDartColor(Colors.orange[200])),
  // ];

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
