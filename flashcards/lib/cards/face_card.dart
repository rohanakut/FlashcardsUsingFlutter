import 'package:flashcards/Listeners/render_next_element.dart';
import 'package:flashcards/cards/answer.dart';
import "package:flutter/material.dart";

class FaceCard extends StatefulWidget {
  FaceCardState createState() => new FaceCardState();
}

class FaceCardState extends State<FaceCard> {
  int i;
  String send, current;
  void initState() {
    i = 0;
    current = dummy[0][0];
    send = dummy[0][1];
  }

  List<List<dynamic>> dummy = [
    ["a", "A", 0],
    ["b", "B", 2],
    ["c", "C", 3],
    ["d", "D", 1],
    ["e", "E", 2],
    ["f", "F", 2],
    ["g", "G", 3]
  ];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        appBar:
            new AppBar(title: Text("Cards")), //deck name should be shown here
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
                            current,
                            textAlign: TextAlign.center,
                          ),
                        )),
                    //Spacer(),
                    Expanded(
                        flex: 1,
                        child: RaisedButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          Answer(send, i)));
                              // NotificationListener<RenderNextElement>(
                              //   child: Text("press me"),
                              //   onNotification: (notification) {
                              //     print(notification.flag);
                              //     setState(() {
                              //       if ((dummy.length) > 1) {
                              //         send = dummy[0][1];
                              //         dummy = dummy.removeAt(0);
                              //         current = dummy[0][1];
                              //       }
                              //     });
                              //   },
                              // );

                              setState(() {
                                if (i < dummy.length) {
                                  i = i + 1;
                                  send = dummy[i][1];
                                  current = dummy[i][0];
                                }
                              });
                              print("button pressed");
                              print(dummy.length);
                            },
                            child: Text("Press Me")))
                  ]))
            ]));
  }
}
