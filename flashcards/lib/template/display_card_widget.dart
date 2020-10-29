import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DisplayCardWidget extends StatelessWidget {
  //final MaterialColor colors;
  String orientation;
  String send;
  DisplayCardWidget(this.orientation, this.send);

  @override
  Widget build(BuildContext context) {
    return new Container(
        alignment: FractionalOffset.center,
        height: 144.0,
        width: 360.0,
        decoration: new BoxDecoration(
          color: Colors.blue.shade50,
          border: new Border.all(color: new Color(0xFF9E9E9E)),
        ),
        child: Text(send));
    //orientation == "front" ? new Text(front[0]) : new Text(back[0]));
  }
}
