import 'dart:async';

import 'package:delayed_display/delayed_display.dart';
import 'package:flashcards/animation/display_card_folding.dart';
import 'package:flashcards/animation/display_card_folding_back.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DisplayCardController extends StatefulWidget {
  DisplayCardControllerState createState() => new DisplayCardControllerState();
}

class DisplayCardControllerState extends State<DisplayCardController>
    with TickerProviderStateMixin {
  List<String> dummy = ["A", "B"];
  List<String> dummy_back = ["a", "b"];
  String send_front, send_back;
  AnimationController _controller;
  Animation<double> _frontScale;
  Animation<double> _backScale;
  Animation<Offset> _offsetAnimation;
  double _opacity = 1;
  Timer _timer;

  @override
  void initState() {
    super.initState();
    send_back = dummy[0];
    send_front = dummy_back[0];
    dummy_back.removeAt(0);
    dummy.removeAt(0);

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
          duration: Duration(milliseconds: 400),
          child: GestureDetector(
              onTap: () {
                setState(() {
                  if (_controller.isCompleted || _controller.velocity > 0)
                    _controller.reverse();
                  else
                    _controller.forward();
                });
              },
              child: new Column(children: <Widget>[
                new Stack(alignment: Alignment.center, children: <Widget>[
                  DisplayCardFoldingBack(_frontScale, send_front),
                  DisplayCardFolding(_backScale, send_back),
                ]),
                RaisedButton(
                    padding:
                        EdgeInsets.only(left: 100.0, bottom: 1.0, top: 1.0),
                    onPressed: () {
                      setState(() {
                        _controller.reverse();
                        _opacity = 0;
                        _timer =
                            new Timer(const Duration(milliseconds: 600), () {
                          setState(() {
                            DisplayCardFolding(_backScale, send_back);
                            _opacity = 1;
                          });
                        });

                        if ((dummy_back.length) != 0) {
                          send_front = dummy_back[0];
                          dummy_back.removeAt(0);
                          send_back = dummy[0];
                          dummy.removeAt(0);
                        } else {
                          send_back = 'end';
                          send_front = "END";
                        }

                        // _controller.reverse();
                        // DisplayCardFolding(_backScale, send_back);
                        // if ((dummy_back.length) != 0) {
                        //   send_front = dummy_back[0];
                        //   dummy_back.removeAt(0);
                        //   send_back = dummy[0];
                        //   dummy.removeAt(0);
                        // } else {
                        //   send_back = 'end';
                        //   send_front = "END";
                        // }
                        //_opacity = 1;
                      });
                      child:
                      Text("next");
                    })
              ])),
          //CardFolding(_backScale),
        ),
      ),
    );
  }
}
