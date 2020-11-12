//import 'dart:html';

import 'package:flashcards/Listeners/render_next_element.dart';
import 'package:flashcards/cards/answer.dart';
import 'package:flashcards/cards/editable_face_card.dart';
import 'package:flashcards/chart/simple_line_chart.dart';
import 'package:flashcards/database/connection/database_helper.dart';
import 'package:flashcards/database/models/cards.dart';
import "package:flutter/material.dart";
import 'package:page_transition/page_transition.dart';

class FaceCard extends StatefulWidget {
  List<String> _questions;
  List<String> _answers;
  List<int> _confidence;
  int _deckNum;
  FaceCard(this._deckNum);
  FaceCardState createState() => new FaceCardState(_deckNum);
}

class FaceCardState extends State<FaceCard> {
  bool _flag = true;
  List<Cards> cardList;

  List<String> _questions = [];
  List<String> _answers = [];
  List<int> _confidence = [3, 3, 3, 3, 3, 3, 3, 3, 3, 3];
  int _deckNum;
  int i;
  int _repetitions;
  DatabaseHelper databaseHelper = DatabaseHelper();

  FaceCardState(this._deckNum);

  void _check() {
    if (_repetitions == 0) {
      print("doing nothing");
    } else if (_repetitions == 1) {}
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

        // if (_repetitions == 3) {
        //   Navigator.push(
        //     context,
        //     PageTransition(
        //       type: PageTransitionType.fade,
        //       child: EditableFaceCard(),
        //     ),
        //   );
        // }
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
    cardList = await databaseHelper.getCardListForReviw(_deckNum);
    print("length is : ${cardList.length}");
    //cardList.map((item) => _questions.insert(0, item.questions)).toList();
    return cardList;
  }

  @override
  void initState() {
    _repetitions = 0;
    i = 0;
    super.initState();
    loadCards().then((value) {
      cardList.map((item) {
        _questions.insert(0, item.questions);
        _answers.insert(0, item.answers);
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
