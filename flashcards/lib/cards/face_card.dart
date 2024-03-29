//import 'dart:html';

import 'package:flashcards/Listeners/render_next_element.dart';
import 'package:flashcards/cards/answer.dart';
import 'package:flashcards/cards/editable_face_card.dart';
import 'package:flashcards/chart/line_chart_widget.dart';
import 'package:flashcards/database/connection/database_helper.dart';
import 'package:flashcards/database/models/cards.dart';
import 'package:flashcards/database/models/chart.dart';
import "package:flutter/material.dart";
import 'package:page_transition/page_transition.dart';

class FaceCard extends StatefulWidget {
  List<String> _questions;
  List<String> _answers;
  List<int> _confidence;
  int _deckNum;
  int _id;
  FaceCard(this._deckNum, this._id);
  FaceCardState createState() => new FaceCardState(_deckNum, _id);
}

class FaceCardState extends State<FaceCard> {
  bool _flag = true;
  List<Cards> cardList;
  int count = 0, _good = 0, _ok = 0, _bad = 0;
  List<String> _questions = [];
  List<String> _answers = [];
  List<int> _confidence = [];
  int _deckNum;
  int i;
  int _repetitions;
  int _id;
  DatabaseHelper databaseHelper = DatabaseHelper();

  FaceCardState(this._deckNum, this._id);

  void _check() {
    if (_repetitions == 0) {
      print("doing nothing");
    } else if (_repetitions == 1) {}
  }

  void _update() async {
    for (int i = 0; i < _confidence.length; i++) {
      //_confidence.map((e) async {
      print("inner value is $i");
      if (_confidence[i] == 1) {
        count++;
        _good++;
      }
      if (_confidence[i] == 2) {
        _ok++;
      }
      if (_confidence[i] == 3) {
        _bad++;
      }
      print("values are ${_questions[i]}");
      print(_answers[i]);
      print(_deckNum);

      print("comfi is ${_confidence[i]}");
      print(_id);
      // print(e.);
      int _check = await databaseHelper.updateConfidence(
          Cards(_questions[i], _answers[i], _deckNum, _confidence[i], _id));
    }
    ;
    print("check is: $_check");
    double _percentage = (count / _confidence.length);
    await databaseHelper
        .insertChart(Chart(_deckNum, _percentage, _id, _good, _ok, _bad));
  }

  void changePage() async {
    //i++;
    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.fade,
        child: Answer(_answers, i),
      ),
    ).then((value) {
      // print("Value is : $value");
      setState(() {
        _confidence[i] = value;
        print("I is : $i");

        if (_repetitions == 3) {
          _update();
          Navigator.pushReplacement(
            context,
            PageTransition(
              type: PageTransitionType.fade,
              child: LineChartWidget(_deckNum, _id),
            ),
          );
        }
        if (_repetitions == 0) {
          if (i < _questions.length - 1)
            i++;
          else if (i >= _questions.length - 1) {
            i = 0;
            _repetitions++;

            // print("in here");
            // print("i is resetted $i");
            // print("repetition is $_repetitions");
          }
        }

        if (_repetitions == 1) {
          //print("in second if");
          for (int j = i + 1; j < _questions.length; j++) {
            if (_confidence[j] == 1 || _confidence[j] == 2) {
              i++;
              print("in loop rep 1");
              // print("in the loop $i");
            } else {
              print("i in rep1 $i");
              print("broke loop rep 1");
              i++;
              break;
            }
          }
          if (i >= _questions.length - 1) {
            i = 0;
            _repetitions++;
            print("i is resetted $i");
          }
          // print("final i is: $i");
        }
        if (_repetitions == 2) {
          print("confidence is : $_confidence");
          // if (i < _questions.length - 1) {
          for (int j = i + 1; j < _questions.length; j++) {
            if (_confidence[j] == 1) {
              print("in loop rep2");
              i++;
            } else {
              print("breaking loop rep 2");
              i++;
              break;
            }
            print("i is: $i");
          }
          //  }
          if (i == _questions.length - 1) {
            i = 0;
            _repetitions++;
          }
        }
      });
      print("repetition is $_repetitions");
    });
  }

  Future<List<Cards>> loadCards() async {
    print("deck num is $_deckNum");
    cardList = await databaseHelper.getCardListForReviw(_deckNum, _id);
    print("length is : ${cardList.length}");
    //cardList.map((item) => _questions.insert(0, item.questions)).toList();
    return cardList;
  }

  @override
  void initState() {
    _repetitions = 0;
    count = 0;
    i = 0;
    super.initState();
    loadCards().then((value) {
      cardList.map((item) {
        _questions.insert(0, item.questions);
        _answers.insert(0, item.answers);
        _confidence.insert(0, item.confidence);
        print("in questions is:$_questions");
        print("in answer is $_answers");
      }).toList();
      //_questions = _questions.reversed.toList();
      setState(() {});
    });
    print("questions is : $_questions");

    //_questions = _questions.reversed.toList();
    // print("list is: ${cardList[0].questions}");
  }

  Widget build(BuildContext context) {
    return new Scaffold(
        // appBar:
        //     new AppBar(title: Text("Cards")), //deck name should be shown here
        body: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
          Expanded(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                Expanded(
                    flex: 9,
                    child: Center(
                      child: Text(
                        _questions[i],
                        textAlign: TextAlign.center,
                      ), //_check(),
                    )),
                //Spacer(),
                Expanded(
                    flex: 1,
                    child: RaisedButton(
                        onPressed: () {
                          changePage();

                          print("button pressed");
                          //print(dummy.length);
                        },
                        child: Text("Press Me")))
              ]))
        ]));
    // TODO: implement build
  }
}
