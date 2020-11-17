import 'package:flashcards/database/connection/database_helper.dart';
import 'package:flashcards/drawer/drawer_for_page.dart';
import 'package:flutter/material.dart';
import 'package:flashcards/database/models/cards.dart';
import 'package:flip_card/flip_card.dart';

class FlipCardNew extends StatefulWidget {
  int _deckNum;
  int _id;
  FlipCardNew(this._deckNum, this._id);
  FlipCardNewState createState() => new FlipCardNewState(_deckNum, _id);
}

class FlipCardNewState extends State<FlipCardNew> {
  int _deckNum;
  int _id, _check;
  FlipCardNewState(this._deckNum, this._id);
  DatabaseHelper databaseHelper = DatabaseHelper();

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
                      left: 32.0, right: 32.0, top: 20.0, bottom: 0.0),
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
                          Expanded(
                            //  margin: EdgeInsets.all(12),
                            //height: 200.0,
                            flex: 2,
                            child: TextField(
                              controller: _cardAdd,
                              maxLines: 20,
                              decoration: InputDecoration(
                                hintText: 'Click here to enter the content',
                                //fillColor: Color(0xFF006666),
                                fillColor: Colors.blue,
                                filled: true,
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                              ),
                            ),
                          ),
                          // Spacer()
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
                          Expanded(
                            //  margin: EdgeInsets.all(12),
                            // height: 200.0,
                            flex: 2,
                            child: TextField(
                              controller: _cardAdd,
                              maxLines: 20,
                              decoration: InputDecoration(
                                hintText: 'Click here to enter the content',
                                //fillColor: Color(0xFF006666),
                                fillColor: Colors.blue[100],
                                filled: true,
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                              ),
                            ),
                          ),
                          //Spacer(),
                          SizedBox(
                              height: 60,
                              child: SizedBox(
                                  width: double.infinity,
                                  child: RaisedButton(
                                    color: Colors.teal[300],
                                    splashColor: Colors.teal,
                                    onPressed: () {
                                      // print("question is: $_question");
                                      //print(_deckNum);
                                      print("answer is: ${_cardAdd.text}");
                                      _addCard(_cardAddBack.text);
                                      Navigator.pop(context);
                                    },
                                    child: Text('Save Card'),
                                  ))),
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
              Expanded(
                flex: 1,
                child: Container(),
              ),
            ],
          )
        ],
      ),
    );
  }
}
