import 'package:flashcards/tutorial/show_cards_tutorial.dart';
import 'package:flutter/material.dart';
import 'package:flutter_intro/flutter_intro.dart';
import 'dart:async';
import 'package:page_transition/page_transition.dart';
import 'package:flashcards/drawer/drawer_for_page.dart';

class DeckListTutorial extends StatefulWidget {
  int _id;
  DeckListTutorial(this._id);
  DeckListTutorialState createState() => new DeckListTutorialState(_id);
}

class DeckListTutorialState extends State<DeckListTutorial> {
  int _id;
  DeckListTutorialState(this._id);
  Intro intro = Intro(
    stepCount: 3,
    padding: EdgeInsets.zero,

    /// use defaultTheme, or you can implement widgetBuilder function yourself
    widgetBuilder: StepWidgetBuilder.useDefaultTheme(
      texts: [
        //  'Hello, welcome to the app, I will guide you once, so that you can start using it seamlessly.',
        'This is the Hall of Decks (A place where all your decks will be stored!)',
        'Want to add more decks?Click here.',
        'I have already created a sample deck for you. Click on OK and press the deck name to move to the next stage'
      ],
      btnLabel: 'OK',
      showStepLabel: true,
    ),
  );
  @override
  void initState() {
    // intro.start(context);
    // TODO: implement initState
    super.initState();
    Timer(Duration(microseconds: 0), () {
      /// start the intro
      intro.start(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          // key: intro.keys[0],
          title: Text("Tutorial"),
        ),
        drawer: DrawerForPage(),
        body: Container(
            // key: intro.keys[0],
            child: Column(children: <Widget>[
          Expanded(
              key: intro.keys[0],
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: 1,
                  itemBuilder: (BuildContext context, int i) {
                    //print(i);
                    return SizedBox(
                        // key: intro.keys[3],
                        child: ListTile(
                            key: intro.keys[2],
                            onTap: () {
                              print(i);
                              Navigator.pushReplacement(
                                context,
                                PageTransition(
                                  type: PageTransitionType.fade,
                                  child: ShowCardsTutorial(_id),
                                ),
                              );
                            },
                            leading: Icon(Icons.list),
                            trailing: Icon(Icons.auto_awesome),
                            title: Text('My first deck')));
                  })
              //: List<Widget>
              ),
          // Spacer(),
          SizedBox(
              child: Container(
                  height: MediaQuery.of(context).size.height * .2,
                  // color: Colors.green,

                  padding: EdgeInsets.only(right: 15, bottom: 10),
                  child: Align(
                      alignment: Alignment.bottomRight,
                      child: FloatingActionButton(
                          key: intro.keys[1],
                          child: Icon(Icons.add),
                          onPressed: () {
                            // _addCard();
                          }))))
          // SizedBox(
          //   child: Placeholder(
          //     /// 2nd guide
          //     key: intro.keys[0],
          //     fallbackHeight: 100,
          //   ),
          // )
        ])));
  }
}
