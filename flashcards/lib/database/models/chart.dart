class Chart {
  int _chartid;
  int _good, _ok, _bad;
  int _deckNumber;
  double _percentage;
  int _userId;

  Chart(this._deckNumber, this._percentage, this._userId, this._good, this._ok,
      this._bad);
  Chart.withId(this._chartid, this._deckNumber, this._percentage, this._userId,
      this._good, this._ok, this._bad);

  int get chartid => _chartid;
  int get deckNumber => _deckNumber;
  double get percentage => _percentage;
  int get id => _userId;
  int get good => _good;
  int get ok => _ok;
  int get bad => _bad;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (_chartid != null) {
      map['chartid'] = _chartid;
    }
    map['deckNum'] = _deckNumber;
    map['percentage'] = _percentage;
    map['id'] = _userId;
    map['good'] = _good;
    map['ok'] = _ok;
    map['bad'] = _bad;
    return map;
  }

  Chart.fromMapObject(Map<String, dynamic> map) {
    this._chartid = map['chartid'];
    this._deckNumber = map['deckNum'];
    this._percentage = map['percentage'];
    this._userId = map['id'];
    this._good = map['good'];
    this._ok = map['ok'];
    this._bad = map['bad'];
  }
}
