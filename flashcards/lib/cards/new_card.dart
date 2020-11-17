import 'package:flashcards/cards/new_card_back.dart';
import 'package:flashcards/drawer/drawer_for_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:page_transition/page_transition.dart';
import 'package:translator/translator.dart';
import 'package:flutter/material.dart';

class NewCard extends StatelessWidget {
  int _deckNum;
  int _id;
  NewCard(this._deckNum, this._id);
  void translation(String input) async {
    final translator = GoogleTranslator();
    //String input = "Je m'appelle rohan";
    translator
        .translate(input, to: 'en')
        .then((result) => print("Source: $input\nTranslated: $result"));
  }

  TextEditingController _cardAdd = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    // print(height);
    // print(width);
    // print((height - 30) / 10);
    final maxLines = 10;
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text('Card Name will be here')),
        drawer: DrawerForPage(),
        body: Column(children: <Widget>[
          // alignment: Alignment.center,
          //width: 300,
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 80),
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
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeft,
                          //  alignment: Alignment.bottomCenter,
                          duration: Duration(seconds: 1),
                          child: NewCardBack(_deckNum, _cardAdd.text, _id),
                        ),
                      ).then((value) {
                        Navigator.pop(context);
                      });
                    },
                    child: Text('Flip'),
                  )))
        ]));
  }
}
