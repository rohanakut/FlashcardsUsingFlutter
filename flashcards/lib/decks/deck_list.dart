import 'package:flashcards/Listeners/add_new_element.dart';
import 'package:flashcards/database/connection/database_helper.dart';
import 'package:flashcards/database/models/decks.dart';
import 'package:flashcards/deck_inside/show_cards.dart';
import 'package:flashcards/decks/deck_add_card.dart';
import 'package:flashcards/drawer/drawer_for_page.dart';
//import 'package:flashcards/template/deck_input.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';

class DeckList extends StatefulWidget {
  int id;
  DeckList(this.id);
  DeckListState createState() => new DeckListState(id);
}

class DeckListState extends State<DeckList>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  int _id;
  DeckListState(this._id);
  FlutterToast ft;
  TextEditingController listAdd = TextEditingController();
  List<String> _to_be_shown = [];
  AnimationController _controller;
  Animation<double> _changeHeight;
  DatabaseHelper databaseHelper = DatabaseHelper();
  int _selected = 0;
  int _check;
  List<Decks> deckList;
  List<Color> cardColor = [
    Color(0xffd0c3f7),
    Color(0xFFb7ecef),
    Color(0xFFedcaf8)
  ];

  List<Color> borderColor = [
    Color(0xffe7c3f7),
    Color(0xffB7ECEF),
    Color(0xfff8cae8),
  ];
  // List<Chart> chartList;

  void _showToast() {
    ft.showToast(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.horizontal(),
          color: Colors.blue[200],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check), //change this
            SizedBox(
              width: 12.0,
            ),
            Text("Deck has been Saved"),
          ],
        ),
      ),
      gravity: ToastGravity.TOP,
      toastDuration: Duration(seconds: 2),
    );
  }

  void addToList() async {
    _to_be_shown.clear();
    deckList = await databaseHelper.getDeckList(_id);
    deckList.map((item) => _to_be_shown.insert(0, item.deckName)).toList();
    _to_be_shown = _to_be_shown.reversed.toList();
    print("length is : ${_to_be_shown.length}");
    // deckList
    //     .map((item) => print({item.deckName, item.id, item.deckNumber}))
    //     .toList();
    setState(() {
      _selected = 0;
      listAdd.clear();
    });
  }

  Future<List<Decks>> loadList() async {
    deckList = await databaseHelper.getDeckList(_id);
    //  chartList = await databaseHelper.getChartList(_deckNum, _id);
    // deckList.map((item) => _to_be_shown.insert(0, item.deckName)).toList();
    // _to_be_shown = _to_be_shown.reversed.toList();
  }

  void changeAnimation() {
    setState(() {
      _selected = 1;
    });
  }

  @override
  void initState() {
    // TODO: implement initState()
    super.initState();
    loadList().then((value) {
      deckList.map((item) => _to_be_shown.insert(0, item.deckName)).toList();
      _to_be_shown = _to_be_shown.reversed.toList();
    });
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    _changeHeight = Tween<double>(begin: 0, end: 60).animate(_controller);
    _changeHeight.addListener(() {
      setState(() {
        //  print(_changeHeight.value.toString());
      });
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<bool> _exitApp() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("You are exiting the app"),
            content: Text(
                "Are you sure you want to exit the Application. Click Yes to proceed"),
            actions: <Widget>[
              RaisedButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text("No")),
              RaisedButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text("Yes")),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: Text("Deck List"),
        ),
        drawer: DrawerForPage(),
        body: WillPopScope(
            onWillPop: _exitApp,
            child: Form(
                key: _form,
                child: Column(children: [
                  Container(
                      height: _selected == 0 ? 0 : _changeHeight.value,
                      child: TextFormField(
                        controller: listAdd,
                        validator: (val) {
                          if (listAdd.text.isEmpty) {
                            return ('Enter some value');
                          }
                        },
                        decoration: _selected == 0
                            ? null
                            : InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Deck Name',
                                suffixIcon: IconButton(
                                    icon: Icon(Icons.save),
                                    onPressed: () {
                                      Future.delayed(Duration(milliseconds: 50),
                                          () async {
                                        FocusScopeNode cF =
                                            FocusScope.of(context);

                                        if (!cF.hasPrimaryFocus) {
                                          cF.unfocus();
                                        }

                                        print("List value is: ${listAdd.text}");
                                        if (listAdd.text.isEmpty) {
                                          _form.currentState.validate();
                                        } else {
                                          _check =
                                              await databaseHelper.insertDeck(
                                                  Decks(listAdd.text, _id));
                                          print("check value is : $_check");
                                          addToList();
                                        }
                                      });
                                    })),
                      )),
                  _to_be_shown.length == 0
                      ? Center(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                              Icon(
                                Icons.home,
                                color: Colors.grey[300],
                                size: 100,
                              ),
                              Text("No deck Avalaible",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.grey[300],
                                  ))
                            ]))
                      : Expanded(
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: _to_be_shown.length,
                              itemBuilder: (BuildContext context, int i) {
                                //print(i);
                                return Padding(
                                    padding: EdgeInsets.fromLTRB(10, 3, 10, 0),
                                    child: Container(
                                        height: 60,
                                        decoration: BoxDecoration(
                                          color: cardColor[(i + 1) % 3],
                                          // border: Border.all(
                                          //     width: 4.0,
                                          //     color: borderColor[(i + 1) % 3],
                                          //     style: BorderStyle.solid),
                                        ),
                                        child: ListTile(
                                            onTap: () {
                                              print(i);
                                              Navigator.push(
                                                context,
                                                PageTransition(
                                                  type: PageTransitionType.fade,
                                                  child: ShowCards(i + 1, _id),
                                                ),
                                              );
                                            },
                                            leading: Icon(Icons.list),
                                            trailing: Icon(Icons.auto_awesome),
                                            title:
                                                Text('${_to_be_shown[i]}'))));
                              })
                          //: List<Widget>
                          ),
                ]))),
        floatingActionButton: _selected == 1
            ? null
            : new FloatingActionButton(
                //textColor: Colors.white,
                //  padding: const EdgeInsets.all(0.0),
                //  shape: RoundedRectangleBorder(
                //      borderRadius: BorderRadius.circular(80.0)),
                child: Container(
                  width: 60,
                  height: 60,
                  child: Icon(
                    Icons.add,
                    size: 40,
                  ),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(colors: [
                        Color(0xFF761cd4),
                        Color(0xFF2F7dd3),
                        Color(0xff21c47b),
                      ])),
                ),
                //   child: Icon(Icons.add),
                onPressed: () {
                  changeAnimation();
                }));
    // TODO: implement build
  }
}
