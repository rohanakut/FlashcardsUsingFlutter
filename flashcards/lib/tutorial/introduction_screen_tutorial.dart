import 'package:flashcards/tutorial/deck_list_tutorial.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:page_transition/page_transition.dart';

class IntroductionScreenTutorial extends StatelessWidget {
  String _id;
  IntroductionScreenTutorial(this._id);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: IntroductionScreen(
            pages: [
          PageViewModel(
              title: "Hello",
              body:
                  "Welcome to the MultiLanguage Flashcard App. Lets start with a tutorial to help you navigate the app.",
              decoration: PageDecoration(
                titleTextStyle:
                    TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
                bodyTextStyle: TextStyle(fontSize: 19.0),
                descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
                pageColor: Colors.white,
                imagePadding: EdgeInsets.zero,
              ))
        ],
            onDone: () {
              Navigator.pushReplacement(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  child: DeckListTutorial(_id),
                ),
              );
            },
            done: const Text('Done',
                style: TextStyle(fontWeight: FontWeight.w600))));
  }
}
