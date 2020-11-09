class Decks {
  int _id;
  String _deckName;
  int _userId;

  Decks(this._deckName, this._userId);
  Decks.withId(this._id, this._deckName);

  int get id => _id;
  String get deckName => _deckName;
  int get userId => _userId;

  set deckName(String newDeck) {
    this._deckName = newDeck;
  }

  set userid(int user) {
    this._userId = user;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['deckNum'] = _id;
    }
    map['deckName'] = _deckName;
    map['id'] = _userId;
    print("Deck name is inside model: $_deckName");

    return map;
  }

  Decks.fromMapObject(Map<String, dynamic> map) {
    this._id = map['deckNum'];
    this._deckName = map['deckName'];
    this._userId = map['id'];
  }
}
