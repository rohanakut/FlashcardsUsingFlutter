import 'package:flashcards/cards/editable_answer_card.dart';
import 'package:flashcards/cards/editable_new_face_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class EditableFaceCard extends StatelessWidget {
  String question, answer;
  int _id, _deckNum, _cardId;
  EditableFaceCard(
      this.question, this._deckNum, this._id, this.answer, this._cardId);

  //print("answer is: $answer");
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(title: Text("Change Card")),
        body: Column(children: <Widget>[
          Container(
            child: Center(
              child: Text("$question"),
            ),
          ),
          Spacer(),
          Container(
              padding: EdgeInsets.only(right: 15, bottom: 10),
              child: Align(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                      child: Icon(Icons.edit),
                      onPressed: () {
                        print(question);
                        print(answer);
                        print(_deckNum);
                        print(_id);
                        Navigator.pushReplacement(
                          context,
                          PageTransition(
                            type: PageTransitionType.fade,
                            child: EditableNewFaceCard(
                                question, answer, _deckNum, _id, _cardId),
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
                      child: EditableAnswerCard(
                          answer, question, _deckNum, _id, _cardId),
                    ),
                  );
                },
                child: Text("Flip"),
              )),
        ]));
  }
}
