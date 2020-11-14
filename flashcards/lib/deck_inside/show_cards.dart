import 'package:flashcards/cards/editable_face_card.dart';
import 'package:flashcards/cards/face_card.dart';
import 'package:flashcards/cards/new_card.dart';
import 'package:flashcards/database/connection/database_helper.dart';
import 'package:flashcards/database/models/cards.dart';
import 'package:flashcards/drawer/drawer_for_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class ShowCards extends StatefulWidget {
  List<String> _questions = [];
  int _deckNum;
  int _id;
  // ShowCards(this._questions);
  ShowCards(this._deckNum, this._id);
  ShowCardsState createState() => new ShowCardsState(_deckNum, _id);
}

class ShowCardsState extends State<ShowCards> {
  ShowCardsState(this._deckNum, this._id);
  List<String> _questions = [];
  List<String> _answers = [];
  List<int> _cardId = [];
  int i;
  int _id;
  int _deckNum;
  Color _color = Colors.white;
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Cards> cardList;

  void _addCard() async {
    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.fade,
        child: NewCard(_deckNum, _id),
      ),
    ).then((value) async {
      _questions = [];
      //cardList.clear();
      cardList = await databaseHelper.getCardList(_deckNum, _id);
      cardList.map((item) => _questions.insert(0, item.questions)).toList();
      cardList.map((item) => _answers.insert(0, item.answers)).toList();
      cardList.map((item) => _cardId.insert(0, item.cardid)).toList();
      _questions = _questions.reversed.toList();
      _answers = _answers.reversed.toList();
      _cardId = _cardId.reversed.toList();
      //print("the rendered list is: $_questions");
      setState(() {});
    });
  }

  Future<List<Cards>> loadCards() async {
    print("deck num is $_deckNum");
    cardList = await databaseHelper.getCardList(_deckNum, _id);
    print("length is : ${cardList.length}");
    //cardList.map((item) => _questions.insert(0, item.questions)).toList();
    return cardList;
  }

  void initState() {
    _questions = [];
    super.initState();
    loadCards().then((value) {
      cardList.map((item) {
        _questions.insert(0, item.questions);
        //  print("in questions is:$_questions");
      }).toList();
      cardList.map((item) => _answers.insert(0, item.answers)).toList();
      cardList.map((item) => _cardId.insert(0, item.cardid)).toList();
      _questions = _questions.reversed.toList();
      _answers = _answers.reversed.toList();
      _cardId = _cardId.reversed.toList();
      setState(() {});
    });
    //  print("questions is : $_questions");

    //_questions = _questions.reversed.toList();
    // print("list is: ${cardList[0].questions}");
  }

  //ShowCardsState(this._questions);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("title"),
      ),
      drawer: DrawerForPage(),
      body: _questions.length == 0
          ? Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                  Icon(
                    Icons.home,
                    color: Colors.grey[300],
                    size: 100,
                  ),
                  Text("No deck Avalaible",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey[300],
                      )),
                  Spacer(),
                  Container(
                      padding: EdgeInsets.only(right: 15, bottom: 15),
                      child: Align(
                          alignment: Alignment.bottomRight,
                          child: FloatingActionButton(
                              child: Icon(Icons.add),
                              onPressed: () {
                                _addCard();
                              })))
                ]))
          : Column(children: [
              Expanded(
                  child: GridView.count(
                primary: false,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
                children: _questions
                    .asMap()
                    .map((index, question) => MapEntry(
                        index,
                        GestureDetector(
                          child: Container(
                              padding: const EdgeInsets.all(8),
                              color: Colors.teal[100],
                              child: Center(
                                  child: Text(question,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5))),
                          onTap: () {
                            setState(() {
                              print("index is: $index");
                              print("answer is: ${_answers[index]}");
                              print("cardid is: ${_cardId[index]}");
                              // print("$question");
                              //  print("$index");
                              Navigator.pushReplacement(
                                context,
                                PageTransition(
                                  type: PageTransitionType.fade,
                                  child: EditableFaceCard(question, _deckNum,
                                      _id, _answers[index], _cardId[index]),
                                ),
                              ).then((value) {
                                setState(() {});
                              });
                            });
                          },
                        )))
                    .values
                    .toList(),
              )),
              Container(
                  padding: EdgeInsets.only(right: 15, bottom: 10),
                  child: Align(
                      alignment: Alignment.bottomRight,
                      child: FloatingActionButton(
                          child: Icon(Icons.add),
                          onPressed: () {
                            _addCard();
                          }))),
              SizedBox(
                  height: 60,
                  width: double.infinity,
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.fade,
                          child: FaceCard(_deckNum, _id),
                        ),
                      );
                    },
                    child: Text("Review"),
                  )),
            ]),
      // Align(
      //     alignment: Alignment.bottomRight,
      //     child: FloatingActionButton(
      //         child: Icon(Icons.add),
      //         onPressed: () {
      //           //  changeAnimation();
      //         }))
    );
  }
}
