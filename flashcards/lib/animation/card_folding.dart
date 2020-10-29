import 'package:flutter/material.dart';

import 'card_controller.dart';
import '../template/card_widget.dart';

class CardFolding extends StatelessWidget {
  //final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Animation backScale;

  // String _question;
  CardFolding(this.backScale);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new AnimatedBuilder(
      child: new CardWidget(colors: Colors.orange),
      animation: backScale,
      builder: (BuildContext context, Widget child) {
        final Matrix4 transform = new Matrix4.identity()
          ..scale(1.0, backScale.value, 1.0);
        return new Transform(
          transform: transform,
          alignment: FractionalOffset.center,
          child: child,
        );
      },
    );
  }
}
