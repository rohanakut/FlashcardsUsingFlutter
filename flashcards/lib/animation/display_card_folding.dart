import 'package:flashcards/template/display_card_widget.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DisplayCardFolding extends StatelessWidget {
  //final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Animation backScale;

  // List<String> dummy = ["A", "B"];
  String send;
  // String _question;
  DisplayCardFolding(this.backScale, this.send);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // send = dummy[0];
    // dummy.removeAt(0);
    // print(dummy);
    return new AnimatedBuilder(
      child: new DisplayCardWidget("front", send),
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
