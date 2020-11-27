import 'package:flashcards/Login/signup_page.dart';
import 'package:flashcards/database/connection/database_helper.dart';
import 'package:flashcards/database/models/login.dart';
import 'package:flashcards/decks/deck_list.dart';
import 'package:flashcards/tutorial/deck_list_tutorial.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  LoginPageState createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  SharedPreferences checkUser;
  bool newUser;
  Future<bool> check_if_exists() async {
    checkUser = await SharedPreferences.getInstance();
    newUser = (checkUser.getBool('login') ?? true);
    print(newUser);
    if (newUser == false) {
      // Navigator.pushReplacement(
      //     context, new MaterialPageRoute(builder: (context) => MyDashboard()));
      print("new user found");
    }
    // } else {
    //   Navigator.pushReplacement(
    //     context,
    //     PageTransition(
    //       type: PageTransitionType.fade,
    //       child: LoginPage(),
    //     ),
    //   );
    // }
    return newUser;
  }

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
  void initState() {
    check_if_exists();
    // TODO: implement initState
    super.initState();
  }

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
                      print("the reurned length is:${check.length}");
                      check_if_exists().then((value) {
                        if (value == true) {
                          Navigator.pushReplacement(
                            context,
                            PageTransition(
                              type: PageTransitionType.fade,
                              child: DeckListTutorial(check[0]['id']),
                            ),
                          );
                        } else {
                          //loginList = databaseHelper.getNoteList();
                          // print("value is ${check[0]['id']}");
                          // print("length is ${check.length}");

                          // _form.currentState.validate();
                          if (check.length != 0) {
                            Navigator.pushReplacement(
                              context,
                              PageTransition(
                                type: PageTransitionType.fade,
                                child: DeckList(check[0]['id']),
                              ),
                            );
                          } else if (check.length <= 0) {
                            _userAdd.clear();
                            _pwdAdd.clear();
                            _form.currentState.validate();
                          }
                        }
                      });
                    },
                    child: Text("Login")),
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
                  child: Text("Create a new Account"),
                )
              ],
            )));
  }
}
