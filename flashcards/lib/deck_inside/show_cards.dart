import 'package:flashcards/cards/editable_face_card.dart';
import 'package:flashcards/cards/face_card.dart';
import 'package:flashcards/cards/flip_card_new.dart';
import 'package:flashcards/cards/flip_face_card.dart';
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
  DatabaseHelper databaseHelper = DatabaseHelper();
  ShowCardsState(this._deckNum, this._id);
  List<String> _questions = [];
  List<String> _answers = [];
  List<Color> cardColor = [
    Color(0xffd0c3f7),
    Color(0xFFb7ecef),
    Color(0xFFedcaf8)
  ];
  List<int> _cardId = [];
  int i;
  int _id;
  int _deckNum;
  Color _color = Colors.white;

  List<Cards> cardList;

  void _addCard() async {
    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.fade,
        //child: FlipCardNew(_deckNum, _id),
        child: NewCard(_deckNum, _id),
      ),
    ).then((value) async {
      _questions = [];
      _answers = [];
      _cardId = [];
      //cardList.clear();
      cardList = await databaseHelper.getCardList(_deckNum, _id);
      cardList.map((item) {
        _questions.insert(0, item.questions);
      }).toList();
      cardList.map((item) => _answers.insert(0, item.answers)).toList();
      cardList.map((item) => _cardId.insert(0, item.cardid)).toList();
      _questions = _questions.reversed.toList();
      _answers = _answers.reversed.toList();
      _cardId = _cardId.reversed.toList();
      print("in func $_questions");
      print("in func $_answers");
      print("in func $_cardId");
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
      print("in init state $_questions");
      print("in init state $_answers");
      print("in init state $_cardId");
      setState(() {});
    });
    //  print("questions is : $_questions");

    //_questions = _questions.reversed.toList();
    // print("list is: ${cardList[0].questions}");
  }

  //ShowCardsState(this._questions);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
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
                  Text("No cards Avalaible",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey[300],
                      )),
                  Spacer(),
                  FloatingActionButton(
                      //textColor: Colors.white,
                      //  padding: const EdgeInsets.all(0.0),
                      //  shape: RoundedRectangleBorder(
                      //      borderRadius: BorderRadius.circular(80.0)),
                      child: Container(
                        width: 60,
                        height: 60,
                        child: Icon(
                          Icons.add,
                          size: 40,
                        ),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(colors: [
                              Color(0xff03d7de),
                              Color(0xFF8766ed),
                              Color(0xFFe117fb),
                            ])),
                      ),
                      //   child: Icon(Icons.add),
                      onPressed: () {
                        _addCard();
                      }),
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
                              color: cardColor[(index + 1) % 3],
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
                              Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.fade,
                                  child: EditableFaceCard(question, _deckNum,
                                      _id, _answers[index], _cardId[index]),
                                ),
                              ).then((value) {
                                if (value == 1)
                                  loadCards().then((value) {
                                    _questions = [];
                                    _answers = [];
                                    _cardId = [];

                                    setState(() {
                                      cardList.map((item) {
                                        _questions.insert(0, item.questions);
                                        //  print("in questions is:$_questions");
                                      }).toList();
                                      cardList
                                          .map((item) =>
                                              _answers.insert(0, item.answers))
                                          .toList();
                                      cardList
                                          .map((item) =>
                                              _cardId.insert(0, item.cardid))
                                          .toList();
                                      _questions = _questions.reversed.toList();
                                      _answers = _answers.reversed.toList();
                                      _cardId = _cardId.reversed.toList();
                                    });
                                  });
                              });
                            });
                          },
                        )))
                    .values
                    .toList(),
              )),
              Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: FloatingActionButton(

                          //textColor: Colors.white,
                          //  padding: const EdgeInsets.all(0.0),
                          //  shape: RoundedRectangleBorder(
                          //      borderRadius: BorderRadius.circular(80.0)),

                          child: Container(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                            width: 60,
                            height: 60,
                            child: Icon(Icons.add, size: 40),

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
                          //   child: Icon(Icons.add),
                          onPressed: () {
                            _addCard();
                          }))),
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
                              child: Text('REVIEW',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                  textAlign: TextAlign.center)),
                        ),
                        onTap: () {
                          print("in ere");
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.fade,
                              child: FlipFaceCard(_deckNum, _id),
                            ),
                          );
                        },
                        // child: Text("Create a new Account"),
                      )))
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
