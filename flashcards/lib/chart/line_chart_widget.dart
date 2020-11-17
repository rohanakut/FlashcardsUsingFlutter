// Code refered from https://github.com/JohannesMilke

import 'package:fl_chart/fl_chart.dart';
import 'package:flashcards/database/connection/database_helper.dart';
import 'package:flashcards/database/models/chart.dart';
//import 'package:fl_line_chart_example/widget/line_titles.dart';
import 'package:flutter/material.dart';

class LineChartWidget extends StatefulWidget {
  int _deckNum, _id;
  LineChartWidget(this._deckNum, this._id);
  LineChartWidgetState createState() =>
      new LineChartWidgetState(this._deckNum, this._id);
}

class LineChartWidgetState extends State<LineChartWidget> {
  LineChartWidgetState(this._deckNum, this._id);
  DatabaseHelper databaseHelper = DatabaseHelper();
  int _deckNum, _id;
  List<Chart> chartList;
  List<FlSpot> _listAdd = [];
  List<double> _percentage = [];
  List<double> _percentageToDisplay;
  final List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];
  Future<List<Chart>> _getData() async {
    chartList = await databaseHelper.getChartList(_deckNum, _id);
    print("length is ${chartList.length}");
    chartList.map((item) => _percentage.insert(0, item.percentage)).toList();
  }

  List<FlSpot> _generate() {
    _getData().then((value) {
      print(_percentage);
      if (_percentage.length < 10) {
        print("percentage is $_percentage");
        for (int i = _percentage.length - 1; i >= 0; i--) {
          _listAdd.insert(0, FlSpot(i.toDouble(), _percentage[i]));
        }
      } else if (_percentage.length >= 10) {
        int j = 0;
        for (int i = 0; i < 11; i++) {
          _listAdd.insert(0, FlSpot(i.toDouble(), _percentage[i]));
          j++;
        }
      }
    });
    print(_listAdd);
    _listAdd = _listAdd.reversed.toList();
    return _listAdd;
  }

  @override
  void initState() {
    _getData().then((value) {
      if (_percentage.length < 10) {
        print("percentage is $_percentage");
        for (int i = _percentage.length - 1; i >= 0; i--) {
          _listAdd.insert(0, FlSpot(i.toDouble(), _percentage[i]));
        }
      } else if (_percentage.length >= 10) {
        int j = 0;
        for (int i = 0; i < 11; i++) {
          _listAdd.insert(0, FlSpot(i.toDouble(), _percentage[i]));
          j++;
        }
      }
      _listAdd = _listAdd.reversed.toList();
      setState(() {});
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text("Chart"),
      ),
      body: Column(children: <Widget>[
        Text(
          "Congratulations!!!!",
          style: TextStyle(fontSize: 35),
        ),
        Text("your deck review has been completed"),
        SizedBox(
          height: 30,
        ),
        //Text("your progress so far is:"),
        //  Spacer(),
        _listAdd.length == 0
            ? Text(
                "you will be able to view your progress as you review the deck more")
            : SizedBox(
                width: 350,
                height: 400,
                child: LineChart(
                  LineChartData(
                    minX: 0,
                    maxX: 11,
                    minY: 0,
                    maxY: 6,
                    //titlesData: LineTitles.getTitleData(),
                    gridData: FlGridData(
                      show: true,
                      getDrawingHorizontalLine: (value) {
                        return FlLine(
                          color: const Color(0xff37434d),
                          strokeWidth: 1,
                        );
                      },
                      // drawVerticalLine: true,
                      // getDrawingVerticalLine: (value) {
                      //   return FlLine(
                      //     color: const Color(0xff37434d),
                      //     strokeWidth: 1,
                      //   );
                      // },
                    ),
                    borderData: FlBorderData(
                      show: true,
                      border:
                          Border.all(color: const Color(0xff37434d), width: 1),
                    ),
                    lineBarsData: [
                      LineChartBarData(
                        spots: _listAdd,
                        // spots: [
                        //   FlSpot(0, 3),
                        //   FlSpot(2.6, 2),
                        //   FlSpot(4.9, 5),
                        //   FlSpot(6.8, 2.5),
                        //   FlSpot(8, 4),
                        //   FlSpot(9.5, 3),
                        //   FlSpot(11, 4),
                        // ],
                        // isCurved: true,
                        // colors: gradientColors,
                        //barWidth: 5,
                        // dotData: FlDotData(show: false),
                        // belowBarData: BarAreaData(
                        //   show: true,
                        //   colors: gradientColors
                        //       .map((color) => color.withOpacity(0.3))
                        //       .toList(),
                        // ),
                      ),
                    ],
                  ),
                ))
      ]));
}
