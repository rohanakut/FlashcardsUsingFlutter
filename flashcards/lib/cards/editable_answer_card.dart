import 'package:flashcards/cards/editable_face_card.dart';
import 'package:flashcards/cards/editable_new_face_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class EditableAnswerCard extends StatelessWidget {
  String _answer, _question, _deckNum, _cardId, _id;
  EditableAnswerCard(
      this._answer, this._question, this._deckNum, this._id, this._cardId);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        appBar: AppBar(title: Text("Change Card")),
        body: Column(children: <Widget>[
          Container(
            child: Center(
              child: Text("$_answer"),
            ),
          ),
          Container(
              padding: EdgeInsets.only(right: 15, bottom: 10),
              child: Align(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                      child: Icon(Icons.add),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          PageTransition(
                            type: PageTransitionType.fade,
                            child: EditableNewFaceCard(
                                _question, _answer, _deckNum, _id, _cardId),
                          ),
                        );
                      }))),
          SizedBox(
              height: 60,
              width: double.infinity,
              child: RaisedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade,
                      child: EditableFaceCard(
                          _question, _deckNum, _id, _answer, _cardId),
                    ),
                  );
                },
                child: Text("Flip"),
              )),
        ]));
  }
}
