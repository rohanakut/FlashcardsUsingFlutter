import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditableFaceCard extends StatelessWidget {
  String question;
  int i;
  EditableFaceCard(this.question, this.i);
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
