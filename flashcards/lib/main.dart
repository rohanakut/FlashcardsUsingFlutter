import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:charts_flutter/flutter.dart';
import 'package:flashcards/Login/login_page.dart';
import 'package:flashcards/animation/card_controller.dart';
import 'package:flashcards/animation/display_card_controller.dart';
import 'package:flashcards/animation/sliding_animation.dart';
import 'package:flashcards/cards/answer.dart';
import 'package:flashcards/cards/face_card.dart';
import 'package:flashcards/cards/new_card.dart';

import 'package:flashcards/chart/display_page.dart';
import 'package:flashcards/chart/line_chart_widget.dart';
import 'package:flashcards/database/loaded_values.dart';
import 'package:flashcards/deck_inside/show_cards.dart';
import 'package:flashcards/decks/deck_list.dart';
import 'package:flashcards/loading/loading_circle.dart';
import 'package:flashcards/navigator/first_time_user.dart';
import 'package:flashcards/tutorial/introduction_screen_tutorial.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';

import 'template/card_widget.dart';

// Amplify Flutter Packages
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
// import 'package:amplify_api/amplify_api.dart'; // UNCOMMENT this line after backend is deployed

// Generated in previous step
import 'models/ModelProvider.dart';
import 'amplifyconfiguration.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  MyAppState createState() => new MyAppState();
}

class MyAppState extends State<MyApp> {
  SharedPreferences checkUser;
  bool newUser;
  bool _amplifyConfigured = false;

  Future<int> check_if_exists() async {
    checkUser = await SharedPreferences.getInstance();
    newUser = (checkUser.getBool('login') ?? true);
    print(newUser);
    if (newUser == false) {
      // Navigator.pushReplacement(
      //     context, new MaterialPageRoute(builder: (context) => MyDashboard()));
      print("new user found");
    }
    // } else {
    //   Navigator.pushReplacement(
    //     context,
    //     PageTransition(
    //       type: PageTransitionType.fade,
    //       child: LoginPage(),
    //     ),
    //   );
    // }
    return 0;
  }

  void _configureAmplify() async {
    // await Amplify.addPlugin(AmplifyAPI()); // UNCOMMENT this line after backend is deployed

    // Once Plugins are added, configure Amplify
    await Future.wait([
      Amplify.addPlugin(
          AmplifyDataStore(modelProvider: ModelProvider.instance)),
      Amplify.addPlugin(AmplifyAPI()),
      Amplify.addPlugin(AmplifyAuthCognito()),
      Amplify.configure(amplifyconfig)
    ]);
    //await Amplify.configure(amplifyconfig);
    try {
      setState(() {
        _amplifyConfigured = true;
        print("Amplify configured");
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    _configureAmplify();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //return new MaterialApp(home: DisplayCardController());
    //home: SlidingAnimation());
    //return new MaterialApp(home: DeckList());
    //return new MaterialApp(home: ToDoList());
    //return new MaterialApp(home: FaceCard(_questions, _answers, _confidence));
    //return new MaterialApp(home: ShowCards(_questions));
    return new MaterialApp(
        theme: ThemeData(primaryColor: Colors.black),
        home: _amplifyConfigured == true ? LoginPage() : LoadingCircle());
    // return new MaterialApp(
    //     theme: ThemeData(primaryColor: Colors.black), home: LineChartWidget());
    //return new MaterialApp(home: LoadedValues());
    // return new MaterialApp(home: NewCard());
    //return new MaterialApp(home: LineChartWidget());
  }
}
