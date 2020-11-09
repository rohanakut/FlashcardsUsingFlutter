import 'package:flashcards/cards/face_card.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class LoadedValues extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // List<List<dynamic>> dummy = [
    //   ["a", "A", 0],
    //   ["b", "B", 2],
    //   ["c", "C", 3],
    //   ["d", "D", 1],
    //   ["e", "E", 2],
    //   ["f", "F", 2],
    //   ["g", "G", 3]
    // ];
    List<String> _questions = ["a", "b", "c", "d", "e", "f", "g"];
    List<String> _answers = ["A", "B", "C", "D", "E", "F", "G"];
    List<int> _confidence = [0, 2, 3, 1, 2, 2, 3];
    print(_questions);
    print(_answers);
    print(_confidence);
    //FaceCard(_questions, _answers, _confidence);
    // TODO: implement build
    return new Scaffold(
        appBar: new AppBar(title: Text("Cards")),
        body: FaceCard(_questions, _answers, _confidence));
  }
}
