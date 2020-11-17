import 'package:charts_flutter/flutter.dart' as charts;

class TodayProgress {
  final String type;
  final int numCards;
  final charts.Color barColor;

  TodayProgress({this.type, this.numCards, this.barColor});
}
