import 'package:flutter/material.dart';

import 'card_controller.dart';
import '../template/card_widget.dart';

class CardFoldingBack extends StatelessWidget {
  Animation frontScale;

  CardFoldingBack(this.frontScale);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new AnimatedBuilder(
      child: new CardWidget(colors: Colors.blue),
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
