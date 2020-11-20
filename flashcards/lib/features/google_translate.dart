import 'package:connectivity/connectivity.dart';
import 'package:flashcards/drawer/drawer_for_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flexible_toast/flutter_flexible_toast.dart';
import 'package:translator/translator.dart';
//import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:edge_alert/edge_alert.dart';

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
    var translation = await translator.translate(input, to: languageB);
    print("Source: $input\nTranslated: $translation");
    setState(() {
      _translateBottom.text = translation.toString();
    });
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
                    checkConnection().then((value) {
                      if (value != null && value) {
                        translation(_translateTop.text, selectedValueTop,
                            selectedValueBottom);
                        print("internet present");
                      } else {
                        showNotifications();
                      }
                    });
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
            // RaisedButton(onPressed: () {
            //   translation("hello", 1, 1);
            // }),
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
