import 'package:flashcards/Listeners/render_next_element.dart';
import 'package:flashcards/cards/answer.dart';
import "package:flutter/material.dart";
import 'package:page_transition/page_transition.dart';

class FaceCard extends StatefulWidget {
  List<String> _questions;
  List<String> _answers;
  List<int> _confidence;
  FaceCard(this._questions, this._answers, this._confidence);
  FaceCardState createState() =>
      new FaceCardState(_questions, _answers, _confidence);
}

class FaceCardState extends State<FaceCard> {
  bool _flag = true;
  void changePage() async {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => Answer(_answers, _confidence)),
    // ).then((value) {
    //   setState(() {});
    // });
    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.fade,
        child: Answer(_answers, _confidence),
      ),
    ).then((value) {
      setState(() {});
    });
  }

  List<String> _questions;
  List<String> _answers;
  List<int> _confidence;
  FaceCardState(this._questions, this._answers, this._confidence);
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        // appBar:
        //     new AppBar(title: Text("Cards")), //deck name should be shown here
        body: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
          Expanded(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                Expanded(
                    flex: 9,
                    child: Center(
                      child: Text(
                        _questions[0],
                        textAlign: TextAlign.center,
                      ),
                    )),
                //Spacer(),
                Expanded(
                    flex: 1,
                    child: RaisedButton(
                        onPressed: () {
                          changePage();
                          _questions.removeAt(0);
                          //changePage();
                          //   NotificationListener<RenderNextElement>(
                          //child: Text("press me"),
                          // onNotification:
                          //(RenderNextElement notification) {
                          //print(notification.flag);
                          //   setState(() {
                          //     //Future.delayed(Duration(seconds: 0), () {
                          //       //setState(() {

                          //       _questions.removeAt(0);

                          //       //  i = i + 1;
                          //       print("The Value is: $_questions.length");
                          //       _flag = !_flag;
                          //       //print("the value of i os $i");
                          //     });
                          //  // });
                          // changePage();
                          //  },
                          //  );

                          // setState(() {
                          //   if (i < dummy.length) {
                          //     i = i + 1;
                          //     send = dummy[i][1];
                          //     current = dummy[i][0];
                          //   }
                          // });
                          print("button pressed");
                          //print(dummy.length);
                        },
                        child: Text("Press Me")))
              ]))
        ]));
    // TODO: implement build
  }
}

// class FaceCard extends StatefulWidget {
//   List<String> _questions;
//   List<String> _answers;
//   List<int> _confidence;
//   FaceCard(this._questions, this._answers, this._confidence);
//   FaceCardState createState() =>
//       new FaceCardState(_questions, _answers, _confidence);
// }

// class FaceCardState extends State<FaceCard> {
//   List<String> _questions;
//   List<String> _answers;
//   List<int> _confidence;
//   FaceCardState(this._questions, this._answers, this._confidence);
//   int i;
//   String send, current;
//   void initState() {
//     i = 0;
//     // current = dummy[0][0];
//     // send = dummy[0][1];
//   }

//   // List<List<dynamic>> dummy = [
//   //   ["a", "A", 0],
//   //   ["b", "B", 2],
//   //   ["c", "C", 3],
//   //   ["d", "D", 1],
//   //   ["e", "E", 2],
//   //   ["f", "F", 2],
//   //   ["g", "G", 3]
//   // ];
//   // List<String> _questions = ["a", "b", "c", "d", "e", "f", "g"];
//   // List<String> _answers = ["A", "B", "C", "D", "E", "F", "G"];
//   // List<int> _confidence = [0, 2, 3, 1, 2, 2, 3];
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build

//     //Currently Loadedvalues is returning a Scaffold but in ideal world
//     //it should just send values and the commented code below should be uncommented
//     return new Scaffold(
//         appBar:
//             new AppBar(title: Text("Cards")), //deck name should be shown here
//         body: Row(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: <Widget>[
//               Expanded(
//                   child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: <Widget>[
//                     Expanded(
//                         flex: 9,
//                         child: Center(
//                           child: Text(
//                             current,
//                             textAlign: TextAlign.center,
//                           ),
//                         )),
//                     //Spacer(),
//                     Expanded(
//                         flex: 1,
//                         child: RaisedButton(
//                             onPressed: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) =>
//                                         Answer(_answers, _confidence)),
//                               );
//                               //   NotificationListener<RenderNextElement>(
//                               //child: Text("press me"),
//                               // onNotification:
//                               //(RenderNextElement notification) {
//                               //print(notification.flag);
//                               setState(() {
//                                 Future.delayed(Duration(seconds: 1), () {
//                                   //setState(() {
//                                   _questions.removeAt(0);
//                                   i = i + 1;
//                                   print("The Value is: $_questions.length");
//                                   print("the value of i os $i");
//                                 });
//                               });
//                               //  },
//                               //  );

//                               // setState(() {
//                               //   if (i < dummy.length) {
//                               //     i = i + 1;
//                               //     send = dummy[i][1];
//                               //     current = dummy[i][0];
//                               //   }
//                               // });
//                               print("button pressed");
//                               //print(dummy.length);
//                             },
//                             child: Text("Press Me")))
//                   ]))
//             ]));
//   }
// }
