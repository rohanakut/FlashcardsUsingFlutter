import 'package:flashcards/Listeners/automatic_rotate.dart';
import 'package:flashcards/input/input_front.dart';
import 'package:flutter/material.dart';

import 'package:flashcards/animation/card_folding.dart';
import 'package:flashcards/animation/card_folding_back.dart';
import 'package:overlay_support/overlay_support.dart';
import './sliding_animation.dart';

class CardController extends StatefulWidget {
  CardControllerState createState() => new CardControllerState();
}

class CardControllerState extends State<CardController>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _frontScale;
  Animation<double> _backScale;
  Animation<Offset> _offsetAnimation;
  double _opacity = 1;
  bool do_not_fade;

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _frontScale = new Tween(
      begin: 1.0,
      end: 0.0,
    ).animate(new CurvedAnimation(
      parent: _controller,
      curve: new Interval(0.0, 0.5, curve: Curves.easeIn),
    ));
    _backScale = new CurvedAnimation(
      parent: _controller,
      curve: new Interval(0.5, 1.0, curve: Curves.easeOut),
    );
    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(1.5, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticIn,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(),
        body: Container(
            child: AnimatedOpacity(
          opacity: _opacity,
          duration: Duration(seconds: 1),
          child: GestureDetector(
            onTap: () {
              setState(() {
                if (_controller.isCompleted || _controller.velocity > 0) {
                  do_not_fade = false;
                  _controller.reverse();
                } else {
                  _controller.forward();
                  do_not_fade = true;
                }
              });
            },
            child: new Column(children: <Widget>[
              new Stack(alignment: Alignment.center, children: <Widget>[
                CardFoldingBack(_frontScale),
                NotificationListener<AutomaticRotate>(
                    child: CardFolding(_backScale),
                    onNotification: (notification) {
                      print(notification.flag);
                      setState(() {
                        _controller.reverse();
                        CardFolding(_backScale);
                      });
                    }),
              ]),
              //CardFolding(_backScale),
              RaisedButton(
                  onPressed: () {
                    print(do_not_fade);
                    if (do_not_fade == true) {
                      setState(() {
                        _opacity = 0;
                      });
                    }
                  },
                  child: Text('Add New Card'))
            ]),
          ),
        )));
  }
}
