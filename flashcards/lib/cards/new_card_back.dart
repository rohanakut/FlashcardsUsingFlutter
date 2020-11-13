import 'package:flashcards/database/connection/database_helper.dart';
import 'package:flashcards/database/models/cards.dart';
import 'package:flutter/cupertino.dart';
import 'package:translator/translator.dart';
import 'package:flutter/material.dart';

class NewCardBack extends StatelessWidget {
  String _question;
  int _deckNum, _check, _id;
  NewCardBack(this._deckNum, this._question, this._id);

  void _addCard(String _answer) async {
    _check = await databaseHelper
        .insertCard(Cards(_question, _answer, _deckNum, 3, _id));
    print(_check);
  }

  void translation(String input) async {
    final translator = GoogleTranslator();
    //String input = "Je m'appelle rohan";
    translator
        .translate(input, to: 'en')
        .then((result) => print("Source: $input\nTranslated: $result"));
  }

  TextEditingController _cardAdd = TextEditingController();
  DatabaseHelper databaseHelper = DatabaseHelper();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    print(height);
    print(width);
    print((height - 30) / 10);
    final maxLines = 10;
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text('Card Name will be here')),
        body: Column(children: <Widget>[
          // alignment: Alignment.center,
          //width: 300,
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 80),
            child: TextField(
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 20,
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
              controller: _cardAdd,
            ),
          ),

          Spacer(),
          SizedBox(
              height: 60,
              child: SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    color: Colors.teal[300],
                    splashColor: Colors.teal,
                    onPressed: () {
                      print("question is: $_question");
                      print(_deckNum);
                      print("answer is: ${_cardAdd.text}");
                      _addCard(_cardAdd.text);
                      Navigator.pop(context);
                    },
                    child: Text('Save Card'),
                  )))
        ]));
  }
}
