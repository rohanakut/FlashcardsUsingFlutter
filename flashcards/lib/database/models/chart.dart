class Chart {
  int _chartid;

  int _deckNumber;
  double _percentage;
  int _userId;

  Chart(this._deckNumber, this._percentage, this._userId);
  Chart.withId(this._chartid, this._deckNumber, this._percentage, this._userId);

  int get chartid => _chartid;
  int get deckNumber => _deckNumber;
  double get percentage => _percentage;
  int get id => _userId;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (_chartid != null) {
      map['chartid'] = _chartid;
    }
    map['deckNum'] = _deckNumber;
    map['percentage'] = _percentage;
    map['id'] = _userId;

    return map;
  }

  Chart.fromMapObject(Map<String, dynamic> map) {
    this._chartid = map['chartid'];
    this._deckNumber = map['deckNum'];
    this._percentage = map['percentage'];
    this._userId = map['id'];
  }
}
