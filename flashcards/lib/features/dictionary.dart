import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:edge_alert/edge_alert.dart';
import 'package:connectivity/connectivity.dart';
import 'dart:async';
import 'package:flashcards/drawer/drawer_for_page.dart';

class Dictionary extends StatefulWidget {
  DictionaryState createState() => new DictionaryState();
}

class DictionaryState extends State<Dictionary> {
  TextEditingController _textDict = TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  _launchURL(String text, int value) async {
    String url;
    switch (value) {
      case 1:
        url = 'https://www.collinsdictionary.com/dictionary/french-english/';
        break;
      case 2:
        url = 'https://www.collinsdictionary.com/dictionary/french-english/';
        break;
    }
    url = url + text;
    // const url = 'https://flutter.dev';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  showNotifications() {
    EdgeAlert.show(context,
        description:
            'Activate the internet and reload the page to use this feature',
        gravity: EdgeAlert.TOP,
        icon: Icons.wifi,
        duration: EdgeAlert.LENGTH_LONG,
        backgroundColor: Colors.black);

    // FlutterFlexibleToast.showToast(
    //     message: "Short Loading 2 Sec Toast",
    //     toastLength: Toast.LENGTH_LONG,
    //     toastGravity: ToastGravity.BOTTOM,
    //     icon: ICON.ERROR,
    //     radius: 100,
    //     elevation: 10,
    //     imageSize: 35,
    //     textColor: Colors.white,
    //     backgroundColor: Colors.black,
    //     timeInSeconds: 2);
  }

  Future<bool> checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  @override
  void initState() {
    checkConnection().then((value) {
      if (value != null && value) {
        print("internet present");
      } else {
        EdgeAlert.show(context,
            description:
                'Activate the internet and reload the page to use this feature ',
            gravity: EdgeAlert.TOP,
            icon: Icons.wifi,
            duration: EdgeAlert.LENGTH_LONG,
            backgroundColor: Colors.black);
      }
      setState(() {});
    });
    super.initState();
  }

  int selectedValueTop;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(title: Text("Dictionary")),
        drawer: DrawerForPage(),
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
                            value: selectedValueTop,
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
                                controller: _textDict,
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
                              checkConnection().then((value) {
                                if (value != null && value) {
                                  _launchURL(_textDict.text, selectedValueTop);
                                  print("internet present");
                                } else {
                                  showNotifications();
                                }
                              });
                              // _launchURL();
                            },
                            child: Text("Search Dictionary"))
                      ],
                    )))));
    // TODO: implement build
  }
}
