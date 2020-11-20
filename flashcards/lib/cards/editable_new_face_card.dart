import 'package:flashcards/cards/editable_new_answer_card.dart';
import 'package:flashcards/database/connection/database_helper.dart';
import 'package:flashcards/database/models/cards.dart';
import 'package:flashcards/deck_inside/show_cards.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class EditableNewFaceCard extends StatefulWidget {
  String _question, _answer;
  int _deckNum, _id, _cardId;

  EditableNewFaceCard(
      this._question, this._answer, this._deckNum, this._id, this._cardId);
  EditableNewFaceCardState createState() =>
      new EditableNewFaceCardState(_question, _answer, _deckNum, _id, _cardId);
}

class EditableNewFaceCardState extends State<EditableNewFaceCard> {
  String _question, _answer;
  int _deckNum, _id, _cardId;
  TextEditingController _cardEditFace = TextEditingController();
  DatabaseHelper databaseHelper = DatabaseHelper();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  EditableNewFaceCardState(
      this._question, this._answer, this._deckNum, this._id, this._cardId);

  void _updateCard() async {
    int _check = await databaseHelper
        .updateCard(_cardId, _cardEditFace.text, _answer)
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
  void initState() {
    // TODO: implement initState
    if (_question != null) {
      setState(() {
        _cardEditFace.text = _question;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final maxLines = 10;
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text('Edit Card')),
        body: Form(
            key: _form,
            child: Column(children: <Widget>[
              // alignment: Alignment.center,
              //width: 300,
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 80),
                child: TextFormField(
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 10,
                  //initialValue: _question,
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
                ),
              ),

              Spacer(),
              Container(
                  padding: EdgeInsets.only(right: 15, bottom: 10),
                  child: Align(
                      alignment: Alignment.bottomRight,
                      child: FloatingActionButton(
                          child: Icon(Icons.save),
                          onPressed: () {
                            _updateCard();
                          }))),
              SizedBox(
                  height: 60,
                  child: SizedBox(
                      width: double.infinity,
                      child: RaisedButton(
                        color: Colors.teal[300],
                        splashColor: Colors.teal,
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.fade,
                                child: EditableNewAnswerCard(_cardEditFace.text,
                                    _answer, _deckNum, _id, _cardId)),
                          );
                        },
                        child: Text('Flip'),
                      )))
            ])));
  }
}
