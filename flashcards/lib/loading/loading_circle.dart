import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class LoadingCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Container(
            child: LoadingIndicator(
                indicatorType: Indicator.ballPulse,

                /// Required, The loading type of the widget
                colors: const [Colors.white],

                /// Optional, The color collections
                strokeWidth: 2,

                /// Optional, The stroke of the line, only applicable to widget which contains line
                backgroundColor: Colors.black,

                /// Optional, Background of the widget
                pathBackgroundColor: Colors.black)));
  }
}
