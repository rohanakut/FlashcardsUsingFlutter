//code refered from https://github.com/smartherd/Flutter-Demos/blob/master/lib/utils/database_helper.dart

import 'dart:io';

import 'package:flashcards/database/models/cards.dart';
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
        "CREATE TABLE $tableName1($deckNumber INTEGER PRIMARY KEY AUTOINCREMENT, deckName TEXT ,$userId INTEGER NOT NULL,FOREIGN KEY($userId) REFERENCES  $tableName('$userId'))");
    await db.execute(
        "CREATE TABLE $tableName2(id INTEGER PRIMARY KEY AUTOINCREMENT, question TEXT, answer TEXT, $deckNumber INTEGER NOT NULL, FOREIGN KEY($deckNumber)REFERENCES $tableName1('$deckNumber'))");
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

  Future<List<Map<String, dynamic>>> getCardMapList(int id) async {
    Database db = await this.database;

    var result = await db
        .rawQuery("SELECT * FROM $tableName2 WHERE $deckNumber = '$id'");
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
    try {
      result = await db.insert(tableName2, card.toMap());
      //result = await db.rawQuery("INSERT ");
    } on Exception catch (_) {
      result = -1;
      // print(e);
    }
    // result = await db.insert(tableName1, deck.toMap());
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

  Future<List<Cards>> getCardList(int id) async {
    var cardMapList = await getCardMapList(id);
    int count = cardMapList.length;

    List<Cards> cardList = List<Cards>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      cardList.add(Cards.fromMapObject(cardMapList[i]));
    }

    return cardList;
  }
}
