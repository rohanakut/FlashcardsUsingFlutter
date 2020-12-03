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
        url = 'https://www.collinsdictionary.com/dictionary/german-english/';
        break;
      case 2:
        url = 'https://www.collinsdictionary.com/dictionary/french-english/';
        break;
      case 3:
        url = 'https://www.collinsdictionary.com/dictionary/italian-english/';
        break;
      case 4:
        url = 'https://www.collinsdictionary.com/dictionary/spanish-english/';
        break;
      case 5:
        url = 'https://www.collinsdictionary.com/dictionary/chinese-english/';
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
            child: Container(

                // width: width - 80,
                // height: height - 100,
                //  padding: const EdgeInsets.only(left: 30, right: 30, top: 80),
                //   color: Colors.teal[100],
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
                                child: Text("German"),
                                value: 1,
                              ),
                              DropdownMenuItem(
                                child: Text("French"),
                                value: 2,
                              ),
                              DropdownMenuItem(
                                child: Text("Italian"),
                                value: 3,
                              ),
                              DropdownMenuItem(
                                child: Text("Spanish"),
                                value: 4,
                              ),
                              DropdownMenuItem(
                                child: Text("Chinese"),
                                value: 5,
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
                                        "Enter the word whose English meaning you want to know"))),
                        SizedBox(
                          height: 20,
                        ),
                        // RaisedButton(
                        //     onPressed: () {
                        //       checkConnection().then((value) {
                        //         if (value != null && value) {
                        //           _launchURL(_textDict.text, selectedValueTop);
                        //           print("internet present");
                        //         } else {
                        //           showNotifications();
                        //         }
                        //       });
                        //       // _launchURL();
                        //     },
                        //     child: Text("Search Dictionary"))
                        Padding(
                            padding: EdgeInsets.fromLTRB(0, 30, 0, 20),
                            child: SizedBox(
                                width: width - 60,
                                height: 50.0,
                                // padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                                child: InkWell(
                                  // textColor: Colors.white,
                                  // color: Color(0xff03d7de),
                                  // shape: RoundedRectangleBorder(
                                  //     borderRadius: BorderRadius.circular(80.0)),

                                  child: Container(
                                    width: double.infinity,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: <Color>[
                                          Color(0xFF47a5cb),
                                          Color(0xFF5bc8cd),
                                          Color(0xffbaf2b3),
                                          // Color(0xFF761cd4),
                                          // Color(0xFF2F7dd3),
                                          // Color(0xff21c47b),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                    ),

                                    // padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                    child: Center(
                                        child: Text('Search Dictionary',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white),
                                            textAlign: TextAlign.center)),
                                  ),
                                  onTap: () {
                                    checkConnection().then((value) {
                                      if (value != null && value) {
                                        _launchURL(
                                            _textDict.text, selectedValueTop);
                                        print("internet present");
                                      } else {
                                        showNotifications();
                                      }
                                    });
                                  },
                                  // child: Text("Create a new Account"),
                                )))
                      ],
                    )))));
    // TODO: implement build
  }
}
