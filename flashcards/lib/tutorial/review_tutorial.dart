import 'package:flashcards/drawer/drawer_for_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_intro/flutter_intro.dart';
import 'dart:async';
import 'package:page_transition/page_transition.dart';
import 'package:flip_card/flip_card.dart';

class ReviewTutorial extends StatefulWidget {
  ReviewTutorialState createState() => new ReviewTutorialState();
}

class ReviewTutorialState extends State<ReviewTutorial> {
  GlobalKey<ReviewTutorialState> cardKey = GlobalKey<ReviewTutorialState>();
  Intro intro = Intro(
    stepCount: 3,
    padding: EdgeInsets.zero,

    /// use defaultTheme, or you can implement widgetBuilder function yourself
    widgetBuilder: StepWidgetBuilder.useDefaultTheme(
      texts: [
        'Here you can review all your flashcards one by one.  The card you created has both your questions and  answers. After you review your flashcard,you can select your response according to your comfort. Some words will be repeated according to your responses',
        'You can select your comfort level here. Bad - not at all comfortable, Ok - somewhat comfortable, Good - Totally comfortable ',
        'By clicking on the card you can check the meaning of the word.',
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

  _renderBg() {
    return Container(
      decoration: BoxDecoration(color: const Color(0xFFFFFFFF)),
    );
  }

  _renderAppBar(context) {
    return MediaQuery.removePadding(
      context: context,
      removeBottom: true,
      child: AppBar(
        brightness: Brightness.dark,
        elevation: 0.0,
        backgroundColor: Color(0x00FFFFFF),
        //backgroundColor: Colors.black,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(key: intro.keys[0], title: Text('FlipCard')),
      drawer: DrawerForPage(),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          _renderBg(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _renderAppBar(context),
              Expanded(
                flex: 4,
                child: Card(
                  elevation: 0.0,
                  margin: EdgeInsets.only(
                      left: 32.0, right: 32.0, top: 50.0, bottom: 50.0),
                  color: Color(0x00000000),
                  child: FlipCard(
                    key: intro.keys[2],
                    direction: FlipDirection.HORIZONTAL,
                    speed: 1000,
                    onFlipDone: (status) {
                      // cardStatus = status;
                    },
                    front: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF006666),
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.fromLTRB(10, 100, 10, 10),
                            height: 200.0,
                            //flex: 2,
                            child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Text("My first Card",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white))),
                          ),
                          Spacer()
                        ],
                      ),
                    ),
                    back: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF006666),
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.fromLTRB(10, 100, 10, 0),
                              height: 200.0,
                              //flex: 2,
                              child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Text(
                                      "This is the answer to my first card",
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.white)))),
                          Spacer()
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Row(key: intro.keys[1], children: <Widget>[
                Expanded(
                    child: RaisedButton(onPressed: () {}, child: Text("Bad"))),
                Expanded(
                    child: RaisedButton(onPressed: () {}, child: Text("Ok"))),
                Expanded(
                    child: RaisedButton(onPressed: () {}, child: Text("Good")))
              ])
            ],
          )
        ],
      ),
    );
  }
}
