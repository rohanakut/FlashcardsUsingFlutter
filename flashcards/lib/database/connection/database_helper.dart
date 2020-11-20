//code refered from https://github.com/smartherd/Flutter-Demos/blob/master/lib/utils/database_helper.dart

import 'dart:io';

import 'package:flashcards/database/models/cards.dart';
import 'package:flashcards/database/models/chart.dart';
import 'package:flashcards/database/models/decks.dart';
import 'package:flashcards/database/models/login.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static DatabaseHelper _helper;
  static Database _database;

  String tableName = 'loginTable';
  String tableName1 = 'deckList';
  String tableName2 = 'cardsList';
  String tableName3 = 'chartList';
  String userId = 'id';
  String userName = 'userName';
  String password = 'pwd';
  String deckNumber = 'deckNum';

  DatabaseHelper._createInstance();
  static Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  factory DatabaseHelper() {
    if (_helper == null) {
      _helper = DatabaseHelper._createInstance();
    }
    return _helper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'login.db';

    // Open/create the database at a given path
    var notesDatabase = await openDatabase(path,
        version: 2, onCreate: _createDb, onConfigure: _onConfigure);
    return notesDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $tableName($userId INTEGER PRIMARY KEY AUTOINCREMENT, $userName TEXT UNIQUE, '
        '$password TEXT)');
    await db.execute(
        "CREATE TABLE $tableName1($deckNumber INTEGER PRIMARY KEY AUTOINCREMENT, deckName  TEXT NOT NULL ,$userId INTEGER NOT NULL,FOREIGN KEY($userId) REFERENCES  $tableName('$userId'))");
    await db.execute(
        "CREATE TABLE $tableName2(cardid INTEGER PRIMARY KEY AUTOINCREMENT, question TEXT, answer TEXT, $deckNumber INTEGER NOT NULL,confidence INTEGER NOT NULL,$userId INTEGER NOT NULL,FOREIGN KEY($userId) REFERENCES  $tableName('$userId'), FOREIGN KEY($deckNumber)REFERENCES $tableName1('$deckNumber'))");
    await db.execute(
        "CREATE TABLE $tableName3(chartid INTEGER PRIMARY KEY AUTOINCREMENT, percentage FLOAT NOT NULL,good INTEGER NOT NULL, bad INTEGER NOT NULL, ok INTEGER NOT NULL,$deckNumber INTEGER NOT NULL,$userId INTEGER NOT NULL,FOREIGN KEY($userId) REFERENCES  $tableName('$userId'), FOREIGN KEY($deckNumber)REFERENCES $tableName1('$deckNumber'))");
  }

  Future<List<Map<String, dynamic>>> getNoteMapList() async {
    Database db = await this.database;

    var result = await db.rawQuery('SELECT * FROM $tableName');
    return result;
  }

  Future<List<Map<String, dynamic>>> getDeckMapList(int id) async {
    Database db = await this.database;

    var result =
        await db.rawQuery("SELECT * FROM $tableName1 WHERE $userId = '$id'");
    return result;
  }

  Future<List<Map<String, dynamic>>> getCardMapList(int id, int uId) async {
    Database db = await this.database;

    var result = await db.rawQuery(
        "SELECT * FROM $tableName2 WHERE ($deckNumber = '$id' AND $userId == '$uId')");
    return result;
  }

  Future<List<Map<String, dynamic>>> getChartMapList(int id, int uId) async {
    Database db = await this.database;

    var result = await db.rawQuery(
        "SELECT * FROM $tableName3 WHERE ($deckNumber = '$id' AND $userId == '$uId')");
    return result;
  }

  Future<int> insertNote(Login login) async {
    // Directory directory = await getApplicationDocumentsDirectory();
    // print(directory.path);
    Database db = await this.database;
    var result;
    try {
      result = await db.insert(tableName, login.toMap());
    } on Exception catch (_) {
      result = -1;
      // print(e);
    }
    return result;
  }

  Future<int> updateConfidence(Cards card) async {
    var db = await this.database;
    // var result = await db.update(tableName2, card.toMap(),
    //     where: '$deckNumber = ? and $userId = ?',
    //     whereArgs: [card.deckNumber, card.id]);
    var result = await db.rawUpdate(
        "UPDATE $tableName2 SET CONFIDENCE  = ? WHERE ($deckNumber = ? AND $userId = ? AND question = ? AND answer = ?)",
        [
          card.confidence,
          card.deckNumber,
          card.id,
          card.questions,
          card.answers
        ]);
    return result;
  }

  Future<int> insertDeck(Decks deck) async {
    Database db = await this.database;
    var result;
    try {
      result = await db.insert(tableName1, deck.toMap());
      //result = await db.rawQuery("INSERT ");
    } on Exception catch (_) {
      result = -1;
      // print(e);
    }
    // result = await db.insert(tableName1, deck.toMap());
    return result;
  }

  Future<int> insertCard(Cards card) async {
    Database db = await this.database;
    var result;
    // try {
    //   result = await db.insert(tableName2, card.toMap());
    //   //result = await db.rawQuery("INSERT ");
    // } on Exception catch (_) {
    //   result = -1;
    //   // print(e);
    // }
    result = await db.insert(tableName2, card.toMap());
    return result;
  }

  Future<int> updateCard(int id, String question, String answer) async {
    var db = await this.database;
    // var result = await db.update(tableName2, card.toMap(),
    //     where: '$deckNumber = ? and $userId = ?',
    //     whereArgs: [card.deckNumber, card.id]);
    var result = await db.rawUpdate(
        "UPDATE $tableName2 SET question = ?,answer=? WHERE (cardid = ?)",
        [question, answer, id]);
    return result;
  }

  Future<int> insertChart(Chart chart) async {
    // Directory directory = await getApplicationDocumentsDirectory();
    // print(directory.path);
    Database db = await this.database;
    var result;
    try {
      result = await db.insert(tableName3, chart.toMap());
    } on Exception catch (_) {
      result = -1;
      // print(e);
    }
    return result;
  }

  Future<List<Map<String, dynamic>>> checkLogin(
      String inputUserName, String inputPwd) async {
    Database db = await this.database;
    var result;
    List<Login> loginList;

    try {
      result = await db.rawQuery(
          "SELECT * FROM loginTable WHERE userName = '$inputUserName' and pwd = '$inputPwd'");
      //loginList.add(Login.fromMapObject(result));
    } on Exception catch (_) {
      result = -1;
    }
    return result;
  }

  Future<int> deleteNote(int id) async {
    var db = await this.database;
    int result =
        await db.rawDelete('DELETE FROM $tableName WHERE $userId = $id');
    return result;
  }

  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $tableName');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<Login>> getNoteList() async {
    var loginMapList = await getNoteMapList();
    int count = loginMapList.length;

    List<Login> loginList = List<Login>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      loginList.add(Login.fromMapObject(loginMapList[i]));
    }

    return loginList;
  }

  Future<List<Decks>> getDeckList(int id) async {
    var deckMapList = await getDeckMapList(id);
    int count = deckMapList.length;

    List<Decks> deckList = List<Decks>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      deckList.add(Decks.fromMapObject(deckMapList[i]));
    }

    return deckList;
  }

  Future<List<Cards>> getCardList(int id, int uId) async {
    var cardMapList = await getCardMapList(id, uId);
    int count = cardMapList.length;
    // print("card list is $cardMapList");
    List<Cards> cardList = List<Cards>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      cardList.add(Cards.fromMapObject(cardMapList[i]));
      // print("card list is ${cardList[0].questions}");
    }

    return cardList;
  }

  Future<List<Cards>> getCardListForReviw(int id, int uId) async {
    var cardMapList = await getCardMapList(id, uId);
    int count = cardMapList.length;
    //print("card list is $cardMapList");

    List<Cards> cardList = List<Cards>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      cardList.add(Cards.fromMapObject(cardMapList[i]));
      // print("card list is ${cardList[0].questions}");
    }
    cardList.shuffle();
    return cardList;
  }

  Future<List<Chart>> getChartList(int id, int uId) async {
    var chartMapList = await getChartMapList(id, uId);
    int count = chartMapList.length;
    // print("chart list is $chartMapList");
    List<Chart> chartList = List<Chart>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      chartList.add(Chart.fromMapObject(chartMapList[i]));
      // print("card list is ${chartList[0].percentage}");
    }

    return chartList;
  }
}
