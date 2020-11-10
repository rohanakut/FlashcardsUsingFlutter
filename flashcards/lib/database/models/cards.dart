class Cards {
  int _id;
  String _questions;
  String _answers;
  int _deckNumber;

  Cards(this._questions, this._answers, this._deckNumber);
  Cards.withId(this._id, this._questions, this._answers, this._deckNumber);

  int get id => _id;
  int get deckNumber => _deckNumber;
  String get questions => _questions;
  String get answers => _answers;

  // set deckName(String newDeck) {
  //   this._deckName = newDeck;
  // }

  // set userid(int user) {
  //   this._userId = user;
  // }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['question'] = _questions;
    map['answer'] = _answers;
    map['deckNum'] = _deckNumber;

    return map;
  }

  Cards.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._deckNumber = map['deckNum'];
    this._questions = map['question'];
    this._answers = map['answer'];
  }
}
