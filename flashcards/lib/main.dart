import 'package:flashcards/Login/login_page.dart';
import 'package:flashcards/animation/card_controller.dart';
import 'package:flashcards/animation/display_card_controller.dart';
import 'package:flashcards/animation/sliding_animation.dart';
import 'package:flashcards/cards/answer.dart';
import 'package:flashcards/cards/face_card.dart';
import 'package:flashcards/cards/new_card.dart';
import 'package:flashcards/chart/simple_line_chart.dart';
import 'package:flashcards/database/loaded_values.dart';
import 'package:flashcards/deck_inside/show_cards.dart';
import 'package:flashcards/decks/deck_list.dart';

import 'package:flutter/material.dart';

import 'template/card_widget.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> _questions = ["a", "b", "c", "d", "e", "f", "g"];
    List<String> _answers = ["A", "B", "C", "D", "E", "F", "G"];
    List<int> _confidence = [0, 2, 3, 1, 2, 2, 3];
    print(_questions);
    print(_answers);
    print(_confidence);

    //return new MaterialApp(home: DisplayCardController());
    //home: SlidingAnimation());
    //return new MaterialApp(home: DeckList());
    //return new MaterialApp(home: ToDoList());
    //return new MaterialApp(home: FaceCard(_questions, _answers, _confidence));
    //return new MaterialApp(home: ShowCards(_questions));
    //return new MaterialApp(home: LoginPage());
    //return new MaterialApp(home: LoadedValues());
    // return new MaterialApp(home: NewCard());
    return new MaterialApp(home: LineChartWidget());
  }
}

// class MyHomePage extends StatefulWidget {
//   MyHomePageState createState() => new MyHomePageState();
// }

// class MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
//   AnimationController _controller;
//   Animation<double> _frontScale;
//   Animation<double> _backScale;

//   @override
//   void initState() {
//     super.initState();
//     _controller = new AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 1),
//     );
//     _frontScale = new Tween(
//       begin: 1.0,
//       end: 0.0,
//     ).animate(new CurvedAnimation(
//       parent: _controller,
//       curve: new Interval(0.0, 0.5, curve: Curves.easeIn),
//     ));
//     _backScale = new CurvedAnimation(
//       parent: _controller,
//       curve: new Interval(0.5, 1.0, curve: Curves.easeOut),
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return CardController();
//     //return new Scaffold(
//     //  appBar: new AppBar(),
//     //  body :
//       // body: GestureDetector(
//       //   onTap: () {
//       //     setState(() {
//       //       if (_controller.isCompleted || _controller.velocity > 0)
//       //         _controller.reverse();
//       //       else
//       //         _controller.forward();
//       //     });
//       //   },
//       //   child: new Stack(
//       //     children: <Widget>[
//       //       new AnimatedBuilder(
//       //         child: new CardWidget(colors: Colors.orange),
//       //         animation: _backScale,
//       //         builder: (BuildContext context, Widget child) {
//       //           final Matrix4 transform = new Matrix4.identity()
//       //             ..scale(1.0, _backScale.value, 1.0);
//       //           return new Transform(
//       //             transform: transform,
//       //             alignment: FractionalOffset.center,
//       //             child: child,
//       //           );
//       //         },
//       //       ),
//       //       new AnimatedBuilder(
//       //         child: new CardWidget(colors: Colors.blue),
//       //         animation: _frontScale,
//       //         builder: (BuildContext context, Widget child) {
//       //           final Matrix4 transform = new Matrix4.identity()
//       //             ..scale(1.0, _frontScale.value, 1.0);
//       //           return new Transform(
//       //             transform: transform,
//       //             alignment: FractionalOffset.center,
//       //             child: child,
//       //           );
//       //         },
//       //       ),
//       //     ],
//       //   ),
//       // ),
//     //);
//   }
// }
