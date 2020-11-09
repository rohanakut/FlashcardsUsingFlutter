class Login {
  int _id;
  String _userName;
  String _pwd;

  Login(this._userName, this._pwd);
  Login.withId(this._id, this._userName, this._pwd);

  int get id => _id;
  String get userName => _userName;
  String get pwd => _pwd;

  set userName(String newUser) {
    this._userName = newUser;
  }

  set pwd(String newPwd) {
    this._pwd = newPwd;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['userName'] = _userName;
    map['pwd'] = _pwd;

    return map;
  }

  Login.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._userName = map['userName'];
    this._pwd = map['pwd'];
  }
}
