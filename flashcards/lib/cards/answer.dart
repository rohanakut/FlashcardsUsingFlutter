import 'package:flashcards/Listeners/render_next_element.dart';
import 'package:flashcards/cards/face_card.dart';
import 'package:flutter/cupertino.dart';

import "package:flutter/material.dart";

class Answer extends StatelessWidget {
  String send;
  int i;
  int _flag = 1;
  Answer(this.send, this.i);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        appBar:
            new AppBar(title: Text("Cards")), //deck name should be shown here
        body: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                    Expanded(
                        child: Center(
                      child: Text(
                        send,
                        textAlign: TextAlign.center,
                      ),
                    )),
                    Spacer(),
                    Row(children: <Widget>[
                      Expanded(
                          child: RaisedButton(
                              onPressed: () {
                                RenderNextElement(flag: _flag)
                                  ..dispatch(context);
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            FaceCard()));
                              },
                              child: Text("Bad"))),
                      Expanded(
                          child: RaisedButton(
                              onPressed: () {
                                RenderNextElement(flag: 1)..dispatch(context);
                              },
                              child: Text("Ok"))),
                      Expanded(
                          child: RaisedButton(
                              onPressed: () {
                                RenderNextElement(flag: 1)..dispatch(context);
                              },
                              child: Text("Good")))
                    ])
                  ]))
            ]));
  }
}
