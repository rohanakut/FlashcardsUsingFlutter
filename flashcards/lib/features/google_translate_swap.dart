import 'package:connectivity/connectivity.dart';
import 'package:flashcards/drawer/drawer_for_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flexible_toast/flutter_flexible_toast.dart';
import 'package:translator/translator.dart';
//import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:edge_alert/edge_alert.dart';

class GoogleTranslateSwap extends StatefulWidget {
  GoogleTranslateSwapState createState() => new GoogleTranslateSwapState();
}

class GoogleTranslateSwapState extends State<GoogleTranslateSwap>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  TextEditingController _translateTop = TextEditingController();
  TextEditingController _translateBottom = TextEditingController();
  AnimationController _controller;
  List<Animation<Offset>> _offsetAnimation;
  bool _flag = true;

  void translation(String input, int langA, int langB, bool mode) async {
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
      case 3:
        languageB = 'de';
        break;
      case 4:
        languageB = 'zh-cn';
        break;
      case 5:
        languageB = 'it';
        break;
      case 6:
        languageB = 'es';
        break;
    }
    var translation = await translator.translate(input, to: languageB);
    print("Source: $input\nTranslated: $translation");
    setState(() {
      if (mode == true)
        _translateBottom.text = translation.toString();
      else {
        _translateTop.text = translation.toString();
      }
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
  }

  @override
  void initState() {
    _flag = true;
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
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _offsetAnimation = List.generate(
      2,
      (index) => Tween<Offset>(
        begin: const Offset(0.0, 0.0),
        end: Offset(0.0, index == 0 ? 2.0 : -1.5),
      ).animate(_controller),
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void _animate() {
    _controller.status == AnimationStatus.completed
        ? _controller.reverse()
        : _controller.forward();
  }

  AppBar appBar = AppBar(title: Text('Translate'));
  int selectedValueTop = 1;
  int selectedValueBottom = 1;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: const Text("Flutter Demo Row Animation")),
      body: Form(
        key: _form,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SlideTransition(
                    position: _offsetAnimation[0],
                    child: Container(
                      margin: EdgeInsets.fromLTRB(12, 0, 12, 12),
                      height: 150.0,
                      child: TextField(
                        controller: _translateTop,
                        maxLines: 10,
                        decoration: InputDecoration(
                          hintText:
                              "Enter any text. It will Auto Detect the language",
                          fillColor: Color(0xffDDF2FD),
                          filled: true,
                        ),
                        onChanged: (text) {
                          if (_flag == true) {
                            checkConnection().then((value) {
                              if (value != null && value) {
                                translation(
                                    _translateTop.text,
                                    selectedValueTop,
                                    selectedValueBottom,
                                    true);
                                print("internet present");
                              } else {
                                showNotifications();
                              }
                            });
                          }
                        },
                      ),
                    )),
                ShaderMask(
                  shaderCallback: (bounds) => RadialGradient(
                    // center: Alignment.center,
                    // radius: 0.6,
                    colors: [
                      Color(0xFFBE94E6),
                      Color(0xFFE1C5FC),
                      Color(0xffE6D5FF),
                    ],
                    tileMode: TileMode.mirror,
                  ).createShader(bounds),
                  child: IconButton(
                    iconSize: 60,
                    icon: Icon(Icons.swap_vert, color: Colors.white, size: 60),
                    onPressed: () {
                      _animate();
                      setState(() {
                        _flag = !_flag;
                        //_translateTop.text = _translateBottom.text;
                      });
                    },
                  ),
                ),
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
                          DropdownMenuItem(
                            child: Text("German"),
                            value: 3,
                          ),
                          DropdownMenuItem(
                            child: Text("Chinese"),
                            value: 4,
                          ),
                          DropdownMenuItem(
                            child: Text("Italian"),
                            value: 5,
                          ),
                          DropdownMenuItem(
                            child: Text("Spanish"),
                            value: 6,
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            bool mode = true;
                            if (_flag == true)
                              mode = true;
                            else {
                              mode = false;
                            }
                            selectedValueBottom = value;
                            translation(_translateTop.text, selectedValueTop,
                                selectedValueBottom, mode);
                          });
                          //print(value);
                        })),
                SlideTransition(
                    position: _offsetAnimation[1],
                    child: Container(
                      margin: EdgeInsets.fromLTRB(12, 0, 12, 12),
                      height: 150.0,
                      child: TextField(
                        controller: _translateBottom,
                        maxLines: 10,
                        decoration: InputDecoration(
                          hintText: "Translation is......",
                          fillColor: Color(0xFFEEFBDD),
                          filled: true,
                        ),
                        onChanged: (text) {
                          if (_flag == false) {
                            checkConnection().then((value) {
                              if (value != null && value) {
                                print(
                                    "Bottom text is ${_translateBottom.text}");
                                translation(
                                    _translateBottom.text,
                                    selectedValueTop,
                                    selectedValueBottom,
                                    false);
                                print("internet present");
                              } else {
                                showNotifications();
                              }
                            });
                          }
                        },
                      ),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
