import 'package:flashcards/Listeners/render_next_element.dart';
import 'package:flashcards/cards/answer.dart';
import 'package:flashcards/database/connection/database_helper.dart';
import 'package:flashcards/database/models/cards.dart';
import "package:flutter/material.dart";
import 'package:page_transition/page_transition.dart';

class FaceCard extends StatefulWidget {
  List<String> _questions;
  List<String> _answers;
  List<int> _confidence;
  int _deckNum;
  FaceCard(this._deckNum);
  FaceCardState createState() => new FaceCardState(_deckNum);
}

class FaceCardState extends State<FaceCard> {
  bool _flag = true;
  List<Cards> cardList;

  List<String> _questions = [];
  List<String> _answers = [];
  List<int> _confidence;
  int _deckNum;
  int i;
  DatabaseHelper databaseHelper = DatabaseHelper();

  FaceCardState(this._deckNum);

  void changePage() async {
    //i++;
    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.fade,
        child: Answer(_answers, i),
      ),
    ).then((value) {
      print("Value is : $value");
      setState(() {
        print(i);
        i++;
      });
    });
  }

  Future<List<Cards>> loadCards() async {
    print("deck num is $_deckNum");
    cardList = await databaseHelper.getCardListForReviw(_deckNum);
    print("length is : ${cardList.length}");
    //cardList.map((item) => _questions.insert(0, item.questions)).toList();
    return cardList;
  }

  @override
  void initState() {
    i = 0;
    super.initState();
    loadCards().then((value) {
      cardList.map((item) {
        _questions.insert(0, item.questions);
        _answers.insert(0, item.answers);
        print("in questions is:$_questions");
        print("in answer is $_answers");
      }).toList();
      //_questions = _questions.reversed.toList();
      setState(() {});
    });
    print("questions is : $_questions");

    //_questions = _questions.reversed.toList();
    // print("list is: ${cardList[0].questions}");
  }

  Widget build(BuildContext context) {
    return new Scaffold(
        // appBar:
        //     new AppBar(title: Text("Cards")), //deck name should be shown here
        body: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
          Expanded(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                Expanded(
                    flex: 9,
                    child: Center(
                      child: Text(
                        _questions[i],
                        textAlign: TextAlign.center,
                      ),
                    )),
                //Spacer(),
                Expanded(
                    flex: 1,
                    child: RaisedButton(
                        onPressed: () {
                          changePage();

                          print("button pressed");
                          //print(dummy.length);
                        },
                        child: Text("Press Me")))
              ]))
        ]));
    // TODO: implement build
  }
}
