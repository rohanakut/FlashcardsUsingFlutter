import 'package:flashcards/decks/deck_list.dart';
import 'package:flashcards/drawer/drawer_for_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_intro/flutter_intro.dart';
import 'dart:async';
import 'package:page_transition/page_transition.dart';
import 'package:flip_card/flip_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReviewTutorial extends StatefulWidget {
  int _id;
  ReviewTutorial(this._id);
  ReviewTutorialState createState() => new ReviewTutorialState(_id);
}

class ReviewTutorialState extends State<ReviewTutorial> {
  int _id;
  SharedPreferences checkUser;
  ReviewTutorialState(this._id);
  GlobalKey<ReviewTutorialState> cardKey = GlobalKey<ReviewTutorialState>();
  Timer timer;
  Intro intro = Intro(
    stepCount: 2,
    padding: EdgeInsets.zero,

    /// use defaultTheme, or you can implement widgetBuilder function yourself
    widgetBuilder: StepWidgetBuilder.useDefaultTheme(
      texts: [
        // 'Here you can review all your flashcards one by one.  The card you created has both your questions and  answers. After you review your flashcard,you can select your response according to your comfort. Some words will be repeated according to your responses',
        // 'You can select your comfort level here. Bad - not at all comfortable, Ok - somewhat comfortable, Good - Totally comfortable ',
        // 'By clicking on the card you can check the meaning of the word.',
        'Lets start reviewing your flashcards. Cannot remember something? Just tap to view the answer. Give yourself a rating based on your performance.(Dont cheat!) .PS- Some words are repeated based on your ratings',
        'Thats all friends!! You can start your learning experience now'
      ],
      btnLabel: 'OK',
      showStepLabel: true,
    ),
  );

  void checkForChange() {
    // do request here
    if (intro.isDone == true) {
      setState(() {
        print("value is changed");

        // change state according to result of request
      });
      Navigator.pushReplacement(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          child: DeckList(_id),
        ),
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void check_if_exists() async {
    checkUser = await SharedPreferences.getInstance();
    checkUser.setBool('login', false);
    // newUser = (checkUser.getBool('login') ?? true);
    // print(newUser);
    // if (newUser == false) {
    //   // Navigator.pushReplacement(
    //   //     context, new MaterialPageRoute(builder: (context) => MyDashboard()));
    //   print("new user found");
    // }
    // } else {
    //   Navigator.pushReplacement(
    //     context,
    //     PageTransition(
    //       type: PageTransitionType.fade,
    //       child: LoginPage(),
    //     ),
    //   );
    // }
  }

  @override
  void initState() {
    // intro.start(context);
    // TODO: implement initState
    check_if_exists();
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) => checkForChange());
    Timer(Duration(microseconds: 0), () {
      /// start the intro
      intro.start(context);
      //print("intro is ${intro.isDone}");
    });
    //print(intro.onFinish);
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
                key: intro.keys[1],
                flex: 4,
                child: Card(
                  elevation: 0.0,
                  margin: EdgeInsets.only(
                      left: 32.0, right: 32.0, top: 50.0, bottom: 50.0),
                  color: Color(0x00000000),
                  child: FlipCard(
                    // key: intro.keys[2],
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
                                child: Text("Bonjour",
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
                                      "It means hello in French",
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.white)))),
                          Spacer()
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Row(children: <Widget>[
                Expanded(
                    child: RaisedButton(
                        onPressed: () {
                          print(intro.isDone);
                        },
                        child: Text("Bad"))),
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
