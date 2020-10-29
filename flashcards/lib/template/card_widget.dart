import 'package:flashcards/Listeners/automatic_rotate.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  @override
  CardWidget({this.colors});

  String _question;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Widget _buildQuestion() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Enter the question'),
      //maxLength: 10,
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

  final MaterialColor colors;
  int _flag;

  Widget build(BuildContext context) {
    return new Container(
      alignment: FractionalOffset.center,
      height: 144.0,
      width: 360.0,
      decoration: new BoxDecoration(
        color: colors.shade50,
        border: new Border.all(color: new Color(0xFF9E9E9E)),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            _buildQuestion(),
            RaisedButton(
              child: Text(
                'Submit',
                style: TextStyle(color: Colors.blue, fontSize: 16),
              ),
              onPressed: () {
                if (!_formKey.currentState.validate()) {
                  return;
                }
                _flag = 1;
                AutomaticRotate(flag: _flag)..dispatch(context);
                _formKey.currentState.save();
                print(_question);
              },
            ),
          ],
        ),
      ),
    );
  }
}
