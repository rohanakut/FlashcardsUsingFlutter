import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';

class Dictionary extends StatefulWidget {
  DictionaryState createState() => new DictionaryState();
}

class DictionaryState extends State<Dictionary> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  _launchURL() async {
    const url = 'https://flutter.dev';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  int selectedValueTop = 1;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(title: Text("Dictionary")),
        body: Container(
            padding:
                const EdgeInsets.only(left: 30, right: 30, top: 30, bottom: 30),
            child: Card(

                // width: width - 80,
                // height: height - 100,
                //  padding: const EdgeInsets.only(left: 30, right: 30, top: 80),
                color: Colors.teal[100],
                child: Padding(
                    padding:
                        const EdgeInsets.only(left: 30, right: 30, top: 80),
                    child: Column(
                      children: <Widget>[
                        DropdownButton(
                            isDense: true,
                            hint: Text("Select Language"),
                            items: [
                              DropdownMenuItem(
                                child: Text("Greman"),
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
                            }),
                        SizedBox(
                          height: 50,
                        ),
                        Form(
                            key: _form,
                            child: TextFormField(
                                minLines: 1,
                                maxLines: 10,
                                decoration: InputDecoration(
                                    hintText:
                                        "Enter the word to be searched"))),
                        SizedBox(
                          height: 20,
                        ),
                        RaisedButton(
                            onPressed: () {
                              _launchURL();
                            },
                            child: Text("Search Dictionary"))
                      ],
                    )))));
    // TODO: implement build
  }
}
