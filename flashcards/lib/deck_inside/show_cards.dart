import 'package:flashcards/cards/editable_face_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class ShowCards extends StatefulWidget {
  List<String> _questions;
  ShowCards(this._questions);
  ShowCardsState createState() => new ShowCardsState(_questions);
}

class ShowCardsState extends State<ShowCards> {
  List<String> _questions;
  int i;
  Color _color = Colors.white;

  ShowCardsState(this._questions);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("title"),
      ),
      body: Column(children: [
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
                                style: Theme.of(context).textTheme.headline5))),
                    onTap: () {
                      setState(() {
                        print("$question");
                        print("$index");
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.fade,
                            child: EditableFaceCard(question, index),
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
            padding: EdgeInsets.only(right: 15, bottom: 15),
            child: Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () {
                      print("in here");
                    })))
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
