class Cards {
  int _cardid;
  String _questions;
  String _answers;
  int _deckNumber;
  int _confidence;
  int _userId;

  Cards(this._questions, this._answers, this._deckNumber, this._confidence,
      this._userId);
  Cards.withId(this._cardid, this._questions, this._answers, this._deckNumber,
      this._confidence, this._userId);

  int get cardid => _cardid;
  int get deckNumber => _deckNumber;
  String get questions => _questions;
  String get answers => _answers;
  int get confidence => _confidence;
  int get id => _userId;

  // set deckName(String newDeck) {
  //   this._deckName = newDeck;
  // }

  // set userid(int user) {
  //   this._userId = user;
  // }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (_cardid != null) {
      map['cardid'] = _cardid;
    }
    map['question'] = _questions;
    map['answer'] = _answers;
    map['deckNum'] = _deckNumber;
    map['confidence'] = _confidence;
    map['id'] = _userId;

    return map;
  }

  Cards.fromMapObject(Map<String, dynamic> map) {
    this._cardid = map['cardid'];
    this._deckNumber = map['deckNum'];
    this._questions = map['question'];
    this._answers = map['answer'];
    this._confidence = map['confidence'];
    this._userId = map['id'];
  }
}
