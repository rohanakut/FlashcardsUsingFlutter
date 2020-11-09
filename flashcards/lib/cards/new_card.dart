import 'package:flutter/cupertino.dart';
import 'package:translator/translator.dart';
import 'package:flutter/material.dart';

class NewCard extends StatelessWidget {
  void translation() async {
    final translator = GoogleTranslator();
    String input = "Je m'appelle rohan";
    translator
        .translate(input, to: 'en')
        .then((result) => print("Source: $input\nTranslated: $result"));
  }

  TextEditingController _cardAdd = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text('Card Name will be here')),
        body: Column(children: <Widget>[
          Container(
              alignment: Alignment.center,
              // width: 300,
              child: TextField(
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 20,
                decoration: InputDecoration(hintText: 'Enter Some Text Here'),
                controller: _cardAdd,
              )),
          Row(
            children: [
              RaisedButton(
                onPressed: () {},
                child: Text("Search Dictionary"),
              ),
              RaisedButton(
                onPressed: () {
                  translation();
                },
                child: Text("Translate"),
              )
            ],
          ),
          Spacer(),
          Container(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    onPressed: () {},
                    child: Text('Flip'),
                  )))
        ]));
  }
}
