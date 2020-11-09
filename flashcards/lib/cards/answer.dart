import 'package:flashcards/Listeners/render_next_element.dart';
import 'package:flashcards/cards/face_card.dart';
import 'package:flutter/cupertino.dart';

import "package:flutter/material.dart";

class Answer extends StatelessWidget {
  // List<String> _answers = ["A", "B", "C", "D", "E", "F", "G"];
  // List<int> _confidence = [0, 2, 3, 1, 2, 2, 3];
  List<String> _answers;
  List<int> _confidence;
  int _flag = 1;
  int i = 0;
  Answer(this._answers, this._confidence);
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
                        _answers[0],
                        textAlign: TextAlign.center,
                      ),
                    )),
                    Spacer(),
                    Row(children: <Widget>[
                      Expanded(
                          child: RaisedButton(
                              onPressed: () {
                                _answers.removeAt(0);
                                _confidence[i] = 3;
                                // RenderNextElement(flag: _flag)
                                //   ..dispatch(context);
                                Navigator.pop(context);
                                print("going back");
                              },
                              child: Text("Bad"))),
                      Expanded(
                          child: RaisedButton(
                              onPressed: () {
                                _answers.removeAt(0);
                                _confidence[i] = 2;
                                RenderNextElement(flag: 1)..dispatch(context);
                              },
                              child: Text("Ok"))),
                      Expanded(
                          child: RaisedButton(
                              onPressed: () {
                                _answers.removeAt(0);
                                _confidence[i] = 1;
                                RenderNextElement(flag: 1)..dispatch(context);
                              },
                              child: Text("Good")))
                    ])
                  ]))
            ]));
  }
}
