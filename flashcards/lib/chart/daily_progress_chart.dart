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
        id: "Your progress in last 10 Attempts",
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
            // Text("Your progress in last 10 Attempts"),
            Expanded(
              child: charts.LineChart(series,
                  behaviors: [
                    new charts.ChartTitle('Your progress in last 10 Attempts',
                        //  subTitle: 'Top sub-title text',
                        behaviorPosition: charts.BehaviorPosition.top,
                        titleOutsideJustification:
                            charts.OutsideJustification.start,
                        // Set a larger inner padding than the default (10) to avoid
                        // rendering the text too close to the top measure axis tick label.
                        // The top tick label may extend upwards into the top margin region
                        // if it is located at the top of the draw area.
                        innerPadding: 18),
                    new charts.ChartTitle('Attempts',
                        //layoutPreferredSize: 10,
                        behaviorPosition: charts.BehaviorPosition.bottom,
                        titleOutsideJustification:
                            charts.OutsideJustification.middleDrawArea),
                    new charts.ChartTitle('Your Progress (%)',
                        behaviorPosition: charts.BehaviorPosition.start,
                        titleOutsideJustification:
                            charts.OutsideJustification.middleDrawArea),
                  ],
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
