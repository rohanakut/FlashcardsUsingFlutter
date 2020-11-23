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
  List<double> _listAdd = [];
  // List<FlSpot> _listAdd = [];
  List<double> _percentage = [];
  List<int> _good = [];
  List<int> _ok = [];
  List<int> _bad = [];
  TodayProgress item1, item2, item3;
  int _goodNum = 0, _badNum = 0, _okNum = 0;
  List<TodayProgress> data = [];
  List<DailyProgress> data1 = [];
  List<double> _percentageToDisplay;
  DisplayPageState(this._deckNum, this._id);

  Future<List<Chart>> _getData() async {
    chartList = await databaseHelper.getChartList(_deckNum, _id);
    print("length is in chart ${chartList.length}");
    chartList.map((item) => _percentage.insert(0, item.percentage)).toList();
    chartList.map((item) => _good.insert(0, item.good)).toList();
    chartList.map((item) => _ok.insert(0, item.ok)).toList();
    chartList.map((item) => _bad.insert(0, item.bad)).toList();
    chartList.map((item) => print("item is : ${item.good}"));
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
    data = [];
    super.initState();
    _getData().then((value) {
      print("in here in charts");
      print("good length is ${_good[0]}");
      print("ok length is ${_ok[0]}");
      print("bad length is ${_bad[0]}");
      if (_good.length != 0) _goodNum = _good[0];
      if (_ok.length != 0) _okNum = _ok[0];
      if (_bad.length != 0) _badNum = _bad[0];
      item1 = TodayProgress(
          type: "bad",
          numCards: _badNum,
          barColor: charts.ColorUtil.fromDartColor(Colors.teal[200]));
      item2 = TodayProgress(
        type: "ok",
        numCards: _okNum,
        barColor: charts.ColorUtil.fromDartColor(Colors.blue[200]),
      );
      item3 = TodayProgress(
          type: "good",
          numCards: _goodNum,
          barColor: charts.ColorUtil.fromDartColor(Colors.orange[200]));
      data.insert(0, item1);
      data.insert(0, item2);
      data.insert(0, item3);
      if (_percentage.length < 10) {
        print("percentage is $_percentage");
        for (int i = 0; i < _percentage.length; i++) {
          int dummy = (_percentage[i] * 100).toInt();
          data1.insert(0, DailyProgress(day: i, confidence: dummy));
        }
      } else if (_percentage.length >= 10) {
        int j = 0;
        for (int i = 0; i < 11; i++) {
          int dummy = (_percentage[i] * 100).toInt();
          data1.insert(0, DailyProgress(day: i, confidence: dummy));
          j++;
        }
      }
      // _listAdd = _listAdd.reversed.toList();

      setState(() {});
    });
    print("data length is ${data.length}");

    // TODO: implement initState
  }

  // List<TodayProgress> data = [
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

  // final List<DailyProgress> data1 = [
  //   DailyProgress(day: 1, confidence: 50),
  //   DailyProgress(day: 2, confidence: 50),
  //   DailyProgress(day: 3, confidence: 60),
  //   DailyProgress(day: 4, confidence: 30),
  //   DailyProgress(day: 5, confidence: 80),
  //   DailyProgress(day: 6, confidence: 100),
  //   DailyProgress(day: 7, confidence: 90),
  //   DailyProgress(day: 8, confidence: 100),
  //   DailyProgress(day: 9, confidence: 100),
  //   DailyProgress(day: 10, confidence: 100)
  // ];

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
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Review")),
      body: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          Container(
            color: Colors.green,
            padding: EdgeInsets.all(15),
            child: Row(children: <Widget>[
              Text(
                "Number of cards reviewed:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(width: 10),
              Text(
                data.length.toString(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              )
            ]),
          ),
          SizedBox(height: 15),
          TodayProgressChart(data),
          DailyProgressChart(data1)
        ],
      )),
    );
  }
}
