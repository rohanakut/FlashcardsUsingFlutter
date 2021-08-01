import 'package:flashcards/database/amplify_db.dart';
import 'package:flashcards/database/connection/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flashcards/deck_inside/show_cards.dart';

class EditableNewCardFlip extends StatefulWidget {
  String _question, _answer, _deckNum, _cardId, _id;

  EditableNewCardFlip(
      this._question, this._answer, this._deckNum, this._id, this._cardId);
  EditableNewCardFlipState createState() =>
      new EditableNewCardFlipState(_question, _answer, _deckNum, _id, _cardId);
}

class EditableNewCardFlipState extends State<EditableNewCardFlip>
    with SingleTickerProviderStateMixin {
  String _question, _answer, _deckNum, _cardId, _id;
  TextEditingController _cardEditFace = TextEditingController();
  TextEditingController _cardEditBack = TextEditingController();
  DatabaseHelper databaseHelper = DatabaseHelper();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  EditableNewCardFlipState(
      this._question, this._answer, this._deckNum, this._id, this._cardId);

  AnimationController _animationController;
  Animation _animation;
  AnimationStatus _animationStatus = AnimationStatus.dismissed;
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  AmplifyDb amplifyObj = AmplifyDb();

  void initState() {
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
    if (_question != null) {
      setState(() {
        _cardEditFace.text = _question;
      });
    }

    if (_answer != null) {
      setState(() {
        _cardEditBack.text = _answer;
      });
    }
  }

  void _updateCard() async {
    int _check = await amplifyObj
        .updateCardData(_cardId, _cardEditFace.text, _cardEditBack.text)
        .then((value) {
      Navigator.pushReplacement(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          child: ShowCards(this._deckNum, this._id),
        ),
      );
    });
    print(_check);
  }

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
                                      controller: _cardEditFace,
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
                                    controller: _cardEditBack,
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
                            child: Icon(Icons.save, size: 30),

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
                            _updateCard();
                            Navigator.pop(context, 1);
                            //  Navigator.pushReplacement(
                            //               context,
                            //               PageTransition(
                            //                 type: PageTransitionType.fade,
                            //                 child: ShowCards(
                            //                   _deckNum,
                            //                   _id,
                            //                 ),
                            //               ),
                            //             );
                          }))),
              // SizedBox(
              //     height: 60,
              //     child: SizedBox(
              //         width: double.infinity,
              //         child: RaisedButton(
              //           color: Colors.teal[300],
              //           splashColor: Colors.teal,
              //           onPressed: () {
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
                          FocusScope.of(context).unfocus();
                          cardKey.currentState.toggleCard();
                        },
                        // child: Text("Create a new Account"),
                      )))
            ]));
  }
}
