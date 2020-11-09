class Cards {
  int _id;
  String _questions;
  String _answers;
  int _deckNumber;

  Cards(this._questions, this._answers, this._deckNumber);
  Cards.withId(this._id, this._questions, this._answers, this._deckNumber);

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
