import 'package:flutter/material.dart';

import '../animation/card_controller.dart';
import '../animation/card_folding.dart';
import '../animation/card_folding_back.dart';

class InputFront extends StatelessWidget {
  Animation backScale;
  InputFront(this.backScale);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _question;

  Widget _buildQuestion() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Enter the question'),
      maxLength: 10,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Question is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _question = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Form(
        key: _formKey,
        child: Column(children: <Widget>[
          CardFolding(backScale),
          RaisedButton(
            child: Text(
              'Submit',
              style: TextStyle(color: Colors.blue, fontSize: 16),
            ),
            onPressed: () {
              if (!_formKey.currentState.validate()) {
                return;
              }
              _formKey.currentState.save();
              print(_question);
            },
          )
        ]));
  }
}
