import 'package:flashcards/database/amplify_db.dart';
import 'package:flashcards/database/connection/database_helper.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';

class NewCard extends StatefulWidget {
  String _deckNum, _id;
  NewCard(this._deckNum, this._id);

  NewCardState createState() => new NewCardState(_deckNum, _id);
}

class NewCardState extends State<NewCard> with SingleTickerProviderStateMixin {
  String _deckNum, _id;
  int _check, _selected = 0;
  AmplifyDb amplifyObj = AmplifyDb();
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  NewCardState(this._deckNum, this._id);
//change code
  AnimationController _animationController;
  Animation _animation;
  AnimationStatus _animationStatus = AnimationStatus.dismissed;
  DatabaseHelper databaseHelper = DatabaseHelper();

  void _addCard(String _question, String _answer) async {
    // _check = await databaseHelper
    //     .insertCard(Cards(_question, _answer, _deckNum, 3, _id));
    _check = await amplifyObj.addCardData(_question, _answer, 3, _deckNum, _id);
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
                  padding: EdgeInsets.only(right: 15, bottom: 10, top: 10),
                  child: Align(
                      alignment: Alignment.bottomRight,
                      child: FloatingActionButton(
                          //child: Icon(Icons.save),
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                            width: 60,
                            height: 60,
                            child: Icon(Icons.save, size: 40),

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
              // SizedBox(
              //     height: 60,
              //     child: SizedBox(
              //         width: double.infinity,
              //         child: RaisedButton(
              //           color: Colors.teal[300],
              //           splashColor: Colors.teal,
              //           onPressed: () {
              //             FocusScope.of(context).unfocus();
              //             cardKey.currentState.toggleCard();
              //             //  setState(() {});
              //           },
              //           child: Text('Flip'),
              //         ))),
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: SizedBox(
                      width: width - 60,
                      height: 50.0,
                      // padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: InkWell(
                        // textColor: Colors.white,
                        // color: Color(0xff03d7de),
                        // shape: RoundedRectangleBorder(
                        //     borderRadius: BorderRadius.circular(80.0)),

                        child: Container(
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: <Color>[
                                Color(0xFF47a5cb),
                                Color(0xFF5bc8cd),
                                Color(0xffbaf2b3),
                                // Color(0xFF761cd4),
                                // Color(0xFF2F7dd3),
                                // Color(0xff21c47b),
                              ],
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),

                          // padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: Center(
                              child: Text('FLIP',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                  textAlign: TextAlign.center)),
                        ),
                        onTap: () {
                          print("in ere");
                          FocusScope.of(context).unfocus();
                          cardKey.currentState.toggleCard();
                        },
                        // child: Text("Create a new Account"),
                      )))
            ]));
  }
}
