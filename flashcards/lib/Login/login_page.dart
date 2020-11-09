import 'package:flashcards/Login/signup_page.dart';
import 'package:flashcards/database/connection/database_helper.dart';
import 'package:flashcards/database/models/login.dart';
import 'package:flashcards/decks/deck_list.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class LoginPage extends StatefulWidget {
  LoginPageState createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  TextEditingController _userAdd = TextEditingController();
  TextEditingController _pwdAdd = TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  String _user;
  String _pwd;
  bool _validate = false;
  bool _validatePwd = false;
  List<Map<String, dynamic>> check;
  //List<Login> check;

  void addToList() {
    setState(() {
      _userAdd.text.isEmpty ? _validate = true : _validate = false;
      _user = _userAdd.text;
      print("User Name: ${_user}");
      _userAdd.clear();
    });
  }

  void insertDatabase(Login login) {
    databaseHelper.insertNote(login);
  }

  void pwdList() {
    setState(() {
      _pwd = _pwdAdd.text;
      _pwdAdd.text.isEmpty ? _validatePwd = true : _validatePwd = false;
      print("password: ${_pwd}");
      _pwdAdd.clear();
    });
  }

  DatabaseHelper databaseHelper = DatabaseHelper();
  Future<List<Login>> loginList;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        appBar: AppBar(title: Text("Login Page")),
        body: Form(
            key: _form,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: _userAdd,
                  validator: (val) {
                    if (check.length == 0) {
                      return ('Wrong username entered');
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Enter User Name',
                    //errorText: _validate ? 'User Name is required' : null,
                  ),
                ),
                TextFormField(
                    controller: _pwdAdd,
                    validator: (val) {
                      if (check.length == 0) {
                        return ('Wrong password entered');
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Enter Password',
                      // errorText: _validatePwd ? 'Password is required' : null,
                    )),
                RaisedButton(
                    onPressed: () async {
                      // addToList();
                      // pwdList();
                      print(_userAdd.text);
                      print(_pwdAdd.text);
                      check = await databaseHelper.checkLogin(
                          _userAdd.text, _pwdAdd.text);

                      //loginList = databaseHelper.getNoteList();
                      print("value is ${check[0]['id']}");
                      print("length is ${check.length}");

                      _form.currentState.validate();
                      if (check.length != 0) {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.fade,
                            child: DeckList(check[0]['id']),
                          ),
                        );
                      } else if (check == -1) {
                        _userAdd.clear();
                        _pwdAdd.clear();
                        _form.currentState.validate();
                      }
                    },
                    child: Text("Press me")),
                SizedBox(),
                RaisedButton(
                  onPressed: () {
                    print("in ere");
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.fade,
                        child: SignupPage(),
                      ),
                    );
                  },
                  child: Text("Sign Up"),
                )
              ],
            )));
  }
}
