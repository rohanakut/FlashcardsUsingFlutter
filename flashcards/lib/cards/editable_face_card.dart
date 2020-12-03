import 'package:flashcards/cards/editable_answer_card.dart';
import 'package:flashcards/cards/editable_new_card_flip.dart';
import 'package:flashcards/cards/editable_new_face_card.dart';
import 'package:flashcards/database/connection/database_helper.dart';
import 'package:flashcards/deck_inside/show_cards.dart';
import 'package:flashcards/drawer/drawer_for_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flashcards/database/models/cards.dart';

class EditableFaceCard extends StatefulWidget {
  String question, answer;
  int _id, _deckNum, _cardId;
  EditableFaceCard(
      this.question, this._deckNum, this._id, this.answer, this._cardId);
  EditableFaceCardState createState() =>
      new EditableFaceCardState(question, _deckNum, _id, answer, _cardId);
}

class EditableFaceCardState extends State<EditableFaceCard> {
  String question, answer;
  int _id, _deckNum, _cardId, _check;
  EditableFaceCardState(
      this.question, this._deckNum, this._id, this.answer, this._cardId);

  //print("answer is: $answer");
  DatabaseHelper databaseHelper = DatabaseHelper();

  Future<int> _deleteCard(int id, int cardId) async {
    _check = await databaseHelper.deleteCard(cardId, id);
  }

  void _addCard(String _answer) async {
    _check = await databaseHelper
        .insertCard(Cards(_cardAdd.text, _answer, _deckNum, 3, _id));
    print(_check);
  }

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

  TextEditingController _cardAdd = TextEditingController();
  TextEditingController _cardAddBack = TextEditingController();
  @override
  void initState() {
    _cardAdd.text = question;
    _cardAddBack.text = answer;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                                child: Text(question,
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
                                  child: Text(answer,
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
              // Container(
              //     padding: EdgeInsets.only(right: 15, bottom: 10),
              //     child: Align(
              //         alignment: Alignment.bottomRight,
              //         child: FloatingActionButton(
              //             child: Icon(Icons.edit),
              //             onPressed: () {
              //               Navigator.pushReplacement(
              //                 context,
              //                 PageTransition(
              //                   type: PageTransitionType.fade,
              //                   child: EditableNewCardFlip(
              //                       question, answer, _deckNum, _id, _cardId),
              //                 ),
              //               );
              //             })))
              Container(
                padding: EdgeInsets.only(right: 15, bottom: 10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: FloatingActionButton(
                              heroTag: "delete",
                              // child: Icon(Icons.delete),
                              child: Container(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                                width: 60,
                                height: 60,
                                child: Icon(Icons.delete, size: 30),

                                // child: Align(
                                //     alignment: Alignment.bottomRight,
                                //     child: FloatingActionButton(
                                //         child: Icon(Icons.add),
                                //         onPressed: () {
                                //           _addCard();
                                //         })),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(colors: [
                                      // Color(0xff03d7de),
                                      // Color(0xFF8766ed),
                                      // Color(0xFFe117fb),
                                      Color(0xFF761cd4),
                                      Color(0xFF2F7dd3),
                                      Color(0xff21c47b),
                                    ])),
                              ),
                              onPressed: () {
                                DeleteAlertBox(
                                    context: context,
                                    title: 'Delete Card',
                                    icon: Icons.delete,
                                    infoMessage:
                                        'Are you sure you want to permanently delete this card?',
                                    onPressedYes: () {
                                      _deleteCard(_id, _cardId).then((value) {
                                        print("card deleted");
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
                                        Navigator.pop(context);
                                        Navigator.pop(context, 1);
                                      });
                                    },
                                    onPressedNo: () {
                                      Navigator.pop(context);
                                    });
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
                              })),
                      SizedBox(
                        width: 25,
                      ),
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: FloatingActionButton(
                              heroTag: "edit",
                              // child: Icon(Icons.edit),
                              child: Container(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                                width: 60,
                                height: 60,
                                child: Icon(Icons.edit, size: 30),

                                // child: Align(
                                //     alignment: Alignment.bottomRight,
                                //     child: FloatingActionButton(
                                //         child: Icon(Icons.add),
                                //         onPressed: () {
                                //           _addCard();
                                //         })),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(colors: [
                                      // Color(0xff03d7de),
                                      // Color(0xFF8766ed),
                                      // Color(0xFFe117fb),
                                      Color(0xFF761cd4),
                                      Color(0xFF2F7dd3),
                                      Color(0xff21c47b),
                                    ])),
                              ),
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.fade,
                                    child: EditableNewCardFlip(question, answer,
                                        _deckNum, _id, _cardId),
                                  ),
                                );
                                // Navigator.pop(context, 1);
                              }))
                    ]),
              )
            ],
          )
        ],
      ),
    );
  }
}
