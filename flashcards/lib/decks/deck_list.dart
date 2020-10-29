import 'package:flashcards/Listeners/add_new_element.dart';
import 'package:flashcards/decks/deck_add_card.dart';
//import 'package:flashcards/template/deck_input.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DeckList extends StatefulWidget {
  DeckListState createState() => new DeckListState();
}

class DeckListState extends State<DeckList>
    with SingleTickerProviderStateMixin {
  FlutterToast ft;
  TextEditingController listAdd = TextEditingController();
  List<String> _to_be_shown = [];
  AnimationController _controller;
  Animation<double> _changeHeight;
  int _selected = 0;

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

  void addToList() {
    setState(() {
      _to_be_shown.insert(0, listAdd.text);
      _selected = 0;
      listAdd.clear();
    });
  }

  void changeAnimation() {
    setState(() {
      _selected = 1;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    _changeHeight = Tween<double>(begin: 0, end: 60).animate(_controller);
    _changeHeight.addListener(() {
      setState(() {
        print(_changeHeight.value.toString());
      });
    });
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: Text("Deck List"),
        ),
        body: Column(children: [
          Container(
              height: _selected == 0 ? 0 : _changeHeight.value,
              child: TextField(
                controller: listAdd,
                decoration: _selected == 0
                    ? null
                    : InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Deck Name',
                        suffixIcon: IconButton(
                            icon: Icon(Icons.save),
                            onPressed: () {
                              Future.delayed(Duration(milliseconds: 50), () {
                                FocusScopeNode cF = FocusScope.of(context);

                                if (!cF.hasPrimaryFocus) {
                                  cF.unfocus();
                                }
                                addToList();
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
                        // return InkWell(
                        //   onTap: () => print("pressed"),
                        return ListTile(
                            leading: Icon(Icons.list),
                            trailing: Icon(Icons.auto_awesome),
                            title: Text('${_to_be_shown[i]}'));
                      })
                  //: List<Widget>
                  ),
        ]),
        floatingActionButton: _selected == 1
            ? null
            : new FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () {
                  changeAnimation();
                }));
    // TODO: implement build
  }
}
