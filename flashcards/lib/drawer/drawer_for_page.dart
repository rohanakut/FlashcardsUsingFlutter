import 'package:flashcards/Login/login_page.dart';
import 'package:flashcards/features/dictionary.dart';
import 'package:flashcards/features/google_translate.dart';
import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class DrawerForPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Drawer Header'),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text('Translate'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => GoogleTranslate()));
              // Update the state of the app
              // ...
              // Then close the drawer
            },
          ),
          ListTile(
            title: Text('Dictionary'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Dictionary()));
              // Update the state of the app
              // ...
              // Then close the drawer
            },
          ),
          ListTile(
            title: Text('Logout'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
          ),
        ],
      ),
    );
  }
}
