import 'package:flashcards/cards/editable_answer_card.dart';
import 'package:flashcards/cards/editable_new_face_card.dart';
import 'package:flashcards/chart/line_chart_widget.dart';
import 'package:flashcards/database/connection/database_helper.dart';
import 'package:flashcards/drawer/drawer_for_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flashcards/database/models/cards.dart';
import 'package:flashcards/chart/line_chart_widget.dart';
import 'package:flashcards/database/models/chart.dart';

class FlipFaceCard extends StatefulWidget {
  List<String> _questions;
  List<String> _answers;
  List<int> _confidence;
  int _deckNum;
  int _id;
  FlipFaceCard(this._deckNum, this._id);
  FlipFaceCardState createState() => new FlipFaceCardState(_deckNum, _id);
}

class FlipFaceCardState extends State<FlipFaceCard> {
  bool _flag = true;
  List<Cards> cardList;
  int count = 0;
  List<String> _questions = [];
  List<String> _answers = [];
  List<int> _confidence = [];
  int _deckNum;
  int i;
  int _repetitions;
  int _id;
  DatabaseHelper databaseHelper = DatabaseHelper();

  FlipFaceCardState(this._deckNum, this._id);
  _renderBg() {
    return Container(
      decoration: BoxDecoration(color: const Color(0xFFFFFFFF)),
    );
  }

  _renderAppBar(context) {
    return MediaQuery.removePadding(
      context: context,
      removeBottom: true,
      child: AppBar(
        brightness: Brightness.dark,
        elevation: 0.0,
        backgroundColor: Color(0x00FFFFFF),
        //backgroundColor: Colors.black,
      ),
    );
  }

  Future<List<Cards>> loadCards() async {
    print("deck num is $_deckNum");
    cardList = await databaseHelper.getCardListForReviw(_deckNum, _id);
    print("length is : ${cardList.length}");
    //cardList.map((item) => _questions.insert(0, item.questions)).toList();
    return cardList;
  }

  void _update() async {
    for (int i = 0; i < _confidence.length; i++) {
      //_confidence.map((e) async {
      print("inner value is $i");
      if (_confidence[i] == 1) {
        count++;
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
    //print("check is: $_check");
    double _percentage = (count / _confidence.length);
    await databaseHelper.insertChart(Chart(_deckNum, _percentage, _id));
  }

  void changePage(int value) async {
    //i++;

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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text('FlipCard')),
      drawer: DrawerForPage(),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          _renderBg(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _renderAppBar(context),
              Expanded(
                flex: 4,
                child: Card(
                  elevation: 0.0,
                  margin: EdgeInsets.only(
                      left: 32.0, right: 32.0, top: 25.0, bottom: 25.0),
                  color: Color(0x00000000),
                  child: FlipCard(
                    direction: FlipDirection.HORIZONTAL,
                    speed: 1000,
                    onFlipDone: (status) {
                      print(status);
                    },
                    front: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF006666),
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.fromLTRB(10, 100, 10, 10),
                            height: 200.0,
                            //flex: 2,
                            child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Text(_questions[i],
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white))),
                          ),
                          Spacer()
                        ],
                      ),
                    ),
                    back: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF006666),
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.fromLTRB(10, 100, 10, 0),
                              height: 200.0,
                              //flex: 2,
                              child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Text(_answers[i],
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.white))
                                  // child: TextField(
                                  //     maxLines: 10,
                                  //     controller: _cardAddBack,
                                  //     decoration: InputDecoration(
                                  //       border: InputBorder.none,
                                  //       focusedBorder: InputBorder.none,
                                  //       enabledBorder: InputBorder.none,
                                  //       errorBorder: InputBorder.none,
                                  //       disabledBorder: InputBorder.none,
                                  //     ),
                                  //     style: TextStyle(
                                  //         fontSize: 15, color: Colors.white)),
                                  )),
                          Spacer()
                          //Spacer(),
                          // Expanded(
                          //     child: Align(
                          //         alignment: Alignment.bottomCenter,
                          //         child: SizedBox(
                          //             height: 60,
                          //             width: double.infinity,
                          //             child: RaisedButton(
                          //               color: Colors.teal[300],
                          //               splashColor: Colors.teal,
                          //               onPressed: () {
                          //                 // print("question is: $_question");
                          //                 //print(_deckNum);
                          //                 print("answer is: ${_cardAdd.text}");
                          //                 _addCard(_cardAddBack.text);
                          //                 Navigator.pop(context);
                          //               },
                          //               child: Text('Save Card'),
                          //             )))),
                        ],
                      ),
                    ),
                    // SizedBox(
                    //           height: 60,
                    //           child: SizedBox(
                    //               width: double.infinity,
                    //               child: RaisedButton(
                    //                 color: Colors.teal[300],
                    //                 splashColor: Colors.teal,
                    //                 onPressed: () {
                    //                   // print("question is: $_question");
                    //                   //print(_deckNum);
                    //                   print("answer is: ${_cardAdd.text}");
                    //                   _addCard(_cardAddBack.text);
                    //                   Navigator.pop(context);
                    //                 },
                    //                 child: Text('Save Card'),
                    //               )))
                  ),
                ),
              ),
              Row(children: <Widget>[
                Expanded(
                    child: RaisedButton(
                        onPressed: () {
                          //  _answers.removeAt(0);
                          //_confidence[i] = 3;
                          // RenderNextElement(flag: _flag)
                          //   ..dispatch(context);
                          //Navigator.pop(context, 3);
                          changePage(3);
                          print("going back");
                        },
                        child: Text("Bad"))),
                Expanded(
                    child: RaisedButton(
                        onPressed: () {
                          changePage(2);
                          //Navigator.pop(context, 2);
                          // _answers.removeAt(0);
                          // _confidence[i] = 2;
                        },
                        child: Text("Ok"))),
                Expanded(
                    child: RaisedButton(
                        onPressed: () {
                          changePage(1);
                          //Navigator.pop(context, 1);
                          //_answers.removeAt(0);
                          // _confidence[i] = 1;
                        },
                        child: Text("Good")))
              ])
            ],
          )
        ],
      ),
    );
  }
}
