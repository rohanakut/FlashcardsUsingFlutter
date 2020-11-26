import 'package:flashcards/Login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:page_transition/page_transition.dart';

//code refered from : https://protocoderspoint.com/shared-preferences-in-flutter-how-to-keep-user-logged/

class FirstTimeUser extends StatefulWidget {
  FirstTimeUserState createState() => new FirstTimeUserState();
}

class FirstTimeUserState extends State<FirstTimeUser> {
  SharedPreferences checkUser;
  bool newUser;

  void check_if_exists() async {
    checkUser = await SharedPreferences.getInstance();
    newUser = (checkUser.getBool('login') ?? true);
    print(newUser);
    if (newUser == false) {
      // Navigator.pushReplacement(
      //     context, new MaterialPageRoute(builder: (context) => MyDashboard()));
      print("new user found");
    } else {
      Navigator.pushReplacement(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          child: LoginPage(),
        ),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
  }
}
