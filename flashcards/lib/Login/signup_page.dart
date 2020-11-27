import 'package:flashcards/Login/login_page.dart';
import 'package:flashcards/database/connection/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:flashcards/database/models/login.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupPage extends StatefulWidget {
  SignupPageState createState() => new SignupPageState();
}

class SignupPageState extends State<SignupPage> {
  TextEditingController _userAdd = TextEditingController();
  TextEditingController _pwdAdd = TextEditingController();
  TextEditingController _reEnterPwd = TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  DatabaseHelper databaseHelper = DatabaseHelper();
  bool _validate = false;
  bool _validateReEnteredPwd = false;
  bool _validatePwd = false;
  String _user;
  String _pwd;
  String reEnter;
  int _check;
  List<Login> loginList;
  SharedPreferences checkUser;
  bool newUser;

  // void addToList() {
  //   setState(() {
  //     _userAdd.text.isEmpty ? _validate = true : _validate = false;
  //     _user = _userAdd.text;
  //     print("User Name: ${_user}");
  //     _userAdd.clear();
  //   });
  // }

  // void pwdList() async {
  //   setState(() {
  //     _pwd = _pwdAdd.text;
  //     _pwdAdd.text.isEmpty ? _validatePwd = true : _validatePwd = false;
  //     print("password: ${_pwd}");
  //     _pwdAdd.clear();
  //   });
  // }

  // void reEnterPwd() async {
  //   setState(() {
  //     reEnter = _reEnterPwd.text;
  //     _reEnterPwd.text.isEmpty
  //         ? _validateReEnteredPwd = true
  //         : _validateReEnteredPwd = false;
  //     _reEnterPwd.clear();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        appBar: AppBar(
          title: Text("SignUp Page"),
        ),
        body: Form(
            key: _form,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: _userAdd,
                  validator: (val) {
                    print("inside val {$val,${_pwdAdd.text}}");
                    if (val.isEmpty) {
                      return 'Username is required';
                    }
                    if (_check == -1) {
                      return 'Username is already taken. Please choose another one.';
                    }
                    // else if (val != _pwdAdd.text) {
                    //   return 'Password does not Match';
                    // }
                    // _reEnterPwd.clear();
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Enter User Name',
                    // errorText: _validate ? 'User Name is required' : null,
                  ),
                ),
                TextFormField(
                    controller: _pwdAdd,
                    obscureText: true,
                    validator: (val) {
                      print("inside val {$val}");
                      if (val.isEmpty) {
                        return 'Password is required';
                      }

                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Enter Password',
                      //errorText: _validatePwd ? 'Password is required' : null,
                    )),
                TextFormField(
                    controller: _reEnterPwd,
                    obscureText: true,
                    validator: (val) {
                      print("inside val {$val,${_pwdAdd.text}}");
                      // if (val.isEmpty) {
                      //   return 'Make sure the field is not empty';
                      //}
                      if (val.isEmpty || val != _pwdAdd.text) {
                        return 'Password does not Match';
                      }
                      // _reEnterPwd.clear();
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Re-Enter Password',
                      errorText:
                          _validateReEnteredPwd ? 'Password is required' : null,
                    )),
                RaisedButton(
                    onPressed: () async {
                      if (_pwdAdd.text == _reEnterPwd.text &&
                          !(_pwdAdd.text.isEmpty) &&
                          !(_reEnterPwd.text.isEmpty)) {
                        // checkUser.setBool('firstTime', true);
                        _check = await databaseHelper
                            .insertNote(Login(_userAdd.text, _pwdAdd.text));
                        print(_check);
                        loginList = await databaseHelper.getNoteList();
                        loginList.map((item) => print(item.userName)).toList();
                        Navigator.pop(
                          context,
                          PageTransition(
                            type: PageTransitionType.fade,
                            child: LoginPage(),
                          ),
                        );
                      }
                      // addToList();
                      // pwdList();
                      _form.currentState.validate();
                      _reEnterPwd.clear();
                      _pwdAdd.clear();
                      _userAdd.clear();
                      // reEnterPwd();
                    },
                    child: Text("Create Account"))
              ],
            )));
  }
}
