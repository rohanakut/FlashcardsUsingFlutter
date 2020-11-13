import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditableFaceCard extends StatelessWidget {
  String question;
  int _id, _deckNum;
  EditableFaceCard(this.question, this._deckNum, this._id);
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: Text("Change Card")),
      body: Container(
        child: Center(
          child: Text("$question"),
        ),
      ),
    );
  }
}
