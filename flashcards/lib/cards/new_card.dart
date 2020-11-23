import 'package:flashcards/cards/new_card_back.dart';
import 'package:flashcards/database/connection/database_helper.dart';
import 'package:flashcards/deck_inside/show_cards.dart';
import 'package:flashcards/drawer/drawer_for_page.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:page_transition/page_transition.dart';
import 'package:translator/translator.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flashcards/database/models/cards.dart';
import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';

class NewCard extends StatefulWidget {
  int _deckNum;
  int _id;
  NewCard(this._deckNum, this._id);

  NewCardState createState() => new NewCardState(_deckNum, _id);
}

class NewCardState extends State<NewCard> with SingleTickerProviderStateMixin {
  int _deckNum;
  int _id, _check, _selected = 0;
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  NewCardState(this._deckNum, this._id);
//change code
  AnimationController _animationController;
  Animation _animation;
  AnimationStatus _animationStatus = AnimationStatus.dismissed;
  DatabaseHelper databaseHelper = DatabaseHelper();

  void _addCard(String _question, String _answer) async {
    _check = await databaseHelper
        .insertCard(Cards(_question, _answer, _deckNum, 3, _id));
    print(_check);
  }

  @override
  void initState() {
    _selected = 0;
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animation = Tween<double>(end: 1, begin: 0).animate(_animationController)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        _animationStatus = status;
      });
  }

//uptill here
  TextEditingController _cardAdd = TextEditingController();
  TextEditingController _cardAddBack = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("Flip"),
        ),
        body: Column(
            // crossAxisAlignment:CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                    FlipCard(
                        key: cardKey,
                        flipOnTouch: false,
                        front: Container(
                            padding: const EdgeInsets.only(
                                left: 30, right: 30, top: 80),
                            child: SizedBox(
                                width: width - 80,
                                child: Container(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20, top: 80),
                                    color: Colors.teal[300],
                                    child: TextField(
                                      keyboardType: TextInputType.multiline,
                                      minLines: 1,
                                      maxLines: 10,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        hintText:
                                            'Enter the Content here. As your content increases the box will automatically increase in size',
                                        fillColor: Colors.teal[300],
                                        filled: true,
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                      ),
                                      controller: _cardAdd,
                                    )))),
                        back: Container(
                          padding: const EdgeInsets.only(
                              left: 30, right: 30, top: 80),
                          child: SizedBox(
                              width: width - 80,
                              child: Container(
                                  padding: const EdgeInsets.only(
                                      left: 0, right: 20, top: 80),
                                  color: Colors.teal[100],
                                  child: TextField(
                                    keyboardType: TextInputType.multiline,
                                    minLines: 1,
                                    maxLines: 10,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      hintText:
                                          'Enter the Content here. As your content increases the box will automatically increase in size',
                                      fillColor: Colors.teal[100],
                                      filled: true,
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                    ),
                                    controller: _cardAddBack,
                                  ))),
                        ))
                  ])),
              Container(
                  padding: EdgeInsets.only(right: 15, bottom: 10),
                  child: Align(
                      alignment: Alignment.bottomRight,
                      child: FloatingActionButton(
                          child: Icon(Icons.save),
                          onPressed: () {
                            if (_cardAdd.text.isEmpty ||
                                _cardAddBack.text.isEmpty) {
                              if (_selected == 0) {
                                setState(() {
                                  _selected = 1;
                                  DarkAlertBox(
                                      context: context,
                                      title: "Empty Card",
                                      messageText:
                                          "You are trying to save an empty card. Click OK if you wish to proceed",
                                      buttonColor: Color(0xFF20242A),
                                      buttonText: "OK",
                                      titleTextColor: Colors.white,
                                      buttonTextColor: Colors.white,
                                      icon: Icons.save,
                                      messageTextColor: Colors.white);
                                });
                              } else if (_selected == 1) {
                                _addCard(_cardAdd.text, _cardAddBack.text);
                                Navigator.pop(context);
                                // Navigator.pushReplacement(
                                //   context,
                                //   PageTransition(
                                //     type: PageTransitionType.fade,
                                //     child: ShowCards(
                                //       _deckNum,
                                //       _id,
                                //     ),
                                //   ),
                                // );
                              }
                            } else {
                              _addCard(_cardAdd.text, _cardAddBack.text);
                              Navigator.pop(context);
                              // Navigator.pushReplacement(
                              //   context,
                              //   PageTransition(
                              //     type: PageTransitionType.fade,
                              //     child: ShowCards(
                              //       _deckNum,
                              //       _id,
                              //     ),
                              //   ),
                              // );
                            }
                          }))),
              SizedBox(
                  height: 60,
                  child: SizedBox(
                      width: double.infinity,
                      child: RaisedButton(
                        color: Colors.teal[300],
                        splashColor: Colors.teal,
                        onPressed: () {
                          cardKey.currentState.toggleCard();
                          //  setState(() {});
                        },
                        child: Text('Flip'),
                      ))),
            ]));
  }
}
