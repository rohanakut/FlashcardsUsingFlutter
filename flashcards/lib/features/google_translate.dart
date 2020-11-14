import 'package:flashcards/drawer/drawer_for_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class GoogleTranslate extends StatefulWidget {
  GoogleTranslateState createState() => new GoogleTranslateState();
}

class GoogleTranslateState extends State<GoogleTranslate> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  TextEditingController _translateTop = TextEditingController();
  TextEditingController _translateBottom = TextEditingController();

  void translation(String input, int langA, int langB) async {
    final translator = GoogleTranslator();
    String languageA, languageB;
    //String input = "Je m'appelle rohan";
    switch (langA) {
      case 1:
        languageA = 'en';
        break;
      case 2:
        languageA = '';
        break;
    }
    switch (langB) {
      case 1:
        languageB = 'fr';
        break;
      case 2:
        languageB = 'en';
        break;
    }
    translator.translate(input, to: languageB).then((result) {
      print("Source: $input\nTranslated: $result");
      setState(() {
        _translateBottom.text = result.toString();
      });
    });
  }

  AppBar appBar = AppBar(title: Text('Demo'));
  int selectedValueTop = 1;
  int selectedValueBottom = 1;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    print("height is $height");
    print("height is $width");
    print("appbar height is ${appBar.preferredSize.height}");
    // TODO: implement build
    return Scaffold(
      appBar: appBar,
      drawer: DrawerForPage(),
      body: Form(
          key: _form,
          child: SingleChildScrollView(
              child: Column(children: <Widget>[
            Column(children: <Widget>[
              Container(
                  width: width - 30,
                  margin: EdgeInsets.fromLTRB(12, 25, 0, 0),
                  child: DropdownButton(
                      isDense: true,
                      value: selectedValueTop,
                      items: [
                        DropdownMenuItem(
                          child: Text("Auto"),
                          value: 1,
                        ),
                        DropdownMenuItem(
                          child: Text("French"),
                          value: 2,
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          selectedValueTop = value;
                        });
                        print(value);
                      })),
              Container(
                margin: EdgeInsets.fromLTRB(12, 0, 12, 12),
                height: 150.0,
                child: TextField(
                  controller: _translateTop,
                  maxLines: 10,
                  decoration: InputDecoration(
                    hintText: "Enter a message",
                    fillColor: Colors.grey[300],
                    filled: true,
                  ),
                  onChanged: (text) {
                    translation(_translateTop.text, selectedValueTop,
                        selectedValueBottom);
                  },
                ),
              ),
            ]),
            IconButton(
              icon: Icon(Icons.swap_vert, color: Colors.grey[300], size: 60),
              onPressed: () {
                setState(() {
                  _translateTop.text = _translateBottom.text;
                });
              },
            ),
            Column(children: <Widget>[
              Container(
                  margin: EdgeInsets.fromLTRB(12, 12, 12, 0),
                  width: width - 30,
                  child: DropdownButton(
                      isDense: true,
                      value: selectedValueBottom,
                      items: [
                        DropdownMenuItem(
                          child: Text("French"),
                          value: 1,
                        ),
                        DropdownMenuItem(
                          child: Text("English"),
                          value: 2,
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          selectedValueBottom = value;
                          translation(_translateTop.text, selectedValueTop,
                              selectedValueBottom);
                        });
                        print(value);
                      })),
              Container(
                //margin: EdgeInsets.all(12),
                margin: EdgeInsets.fromLTRB(12, 0, 12, 12),
                height: 150.0,
                child: TextField(
                  controller: _translateBottom,
                  maxLines: 10,
                  decoration: InputDecoration(
                    hintText: "Enter a message",
                    fillColor: Colors.grey[300],
                    filled: true,
                  ),
                ),
              )
            ]),
          ]))),
    );
  }
}
