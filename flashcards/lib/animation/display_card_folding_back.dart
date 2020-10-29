import 'package:flashcards/template/display_card_widget.dart';
import 'package:flutter/material.dart';

class DisplayCardFoldingBack extends StatelessWidget {
  Animation frontScale;
  //List<String> dummy_back = ["a", "b"];
  String send;
  DisplayCardFoldingBack(this.frontScale, this.send);
  @override
  Widget build(BuildContext context) {
    // send = dummy_back[0];
    // dummy_back.removeAt(0);

    // TODO: implement build
    return new AnimatedBuilder(
      child: new DisplayCardWidget("back", send),
      animation: frontScale,
      builder: (BuildContext context, Widget child) {
        final Matrix4 transform = new Matrix4.identity()
          ..scale(1.0, frontScale.value, 1.0);
        return new Transform(
          transform: transform,
          alignment: FractionalOffset.center,
          child: child,
        );
      },
    );
  }
}
