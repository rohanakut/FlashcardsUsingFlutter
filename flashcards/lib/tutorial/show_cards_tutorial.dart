import 'package:flashcards/tutorial/review_tutorial.dart';
import 'package:flutter/material.dart';
import 'package:flutter_intro/flutter_intro.dart';
import 'dart:async';
import 'package:page_transition/page_transition.dart';

class ShowCardsTutorial extends StatefulWidget {
  ShowCardsTutorialState createState() => new ShowCardsTutorialState();
}

class ShowCardsTutorialState extends State<ShowCardsTutorial> {
  Intro intro = Intro(
    stepCount: 2,
    padding: EdgeInsets.zero,

    /// use defaultTheme, or you can implement widgetBuilder function yourself
    widgetBuilder: StepWidgetBuilder.useDefaultTheme(
      texts: [
        'This is where all your cards of the deck will be stored. You can edit or delete the cards by clicking on the particular card.',
        //'You can add more cards by clicking on the button.',
        //'You can edit or delete the cards by clicking on the particular card.',
        'By clicking on the review button we can review and memorise all the cards that we have created here. Click on OK and press the Review Button to move to the next stage'
      ],
      btnLabel: 'OK',
      showStepLabel: true,
    ),
  );

  List<String> _questions;
  @override
  void initState() {
    _questions = [
      "first card",
      "second card",
      "third card",
      "fourth card",
      "fifth card",
      "sixth card",
      "seventh card",
      "eighth card",
      "nineth card",
      "tenth card"
    ];
    Timer(Duration(microseconds: 0), () {
      /// start the intro
      intro.start(context);
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          key: intro.keys[0],
          title: Text("Tutorial"),
        ),
        body: Column(children: [
          Expanded(
              // key: intro.keys[0],
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
                          //key: intro.keys[2],
                          padding: const EdgeInsets.all(8),
                          color: Colors.teal[100],
                          child: Center(
                              child: Text(question,
                                  style:
                                      Theme.of(context).textTheme.headline5))),
                    )))
                .values
                .toList(),
          )),
          Container(
              padding: EdgeInsets.only(right: 15, bottom: 10),
              child: Align(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                      // key: intro.keys[1],
                      child: Icon(Icons.add),
                      onPressed: () {
                        // _addCard();
                      }))),
          SizedBox(
              height: 60,
              width: double.infinity,
              child: RaisedButton(
                key: intro.keys[1],
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade,
                      child: ReviewTutorial(),
                    ),
                  );
                },
                child: Text("Review"),
              )),
        ]));
  }
}
