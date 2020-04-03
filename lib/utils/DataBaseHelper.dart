import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wordandmemory/model/word.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;

  String wordTable = 'word_table';
  String colId = 'id';
  String colTotalAns = 'totalAnswer';
  String colAvgAns = 'avgAnswer';
  String colCorrectAns = 'correctAnswer';
  String colTr = 'tr';
  String colEn = 'en';
  String colSentenceEn = 'sentenceEn';
  String colSentenceTr = 'sentenceTr';
  String colCreated = 'createdTime';

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'words.db';
    var wordsDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return wordsDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $wordTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTr TEXT, $colEn TEXT,$colSentenceTr TEXT,$colSentenceEn TEXT,$colCreated TEXT,$colCorrectAns INTEGER,$colTotalAns INTEGER,$colAvgAns INTEGER)');
  }

  Future<List<Map<String, dynamic>>> getWordMapList() async {
    Database db = await this.database;
    var result = await db.query(wordTable);
    return result;
  }

  Future<int> insertWord(Word w) async {
    Database db = await this.database;
    var result = await db.insert(wordTable, w.toJson());
    return result;
  }

  Future<int> updateWord(Word w) async {
    var db = await this.database;
    var result = await db
        .update(wordTable, w.toJson(), where: '$colId = ?', whereArgs: [w.id]);
    return result;
  }

  Future<int> deleteWord(int id) async {
    var db = await this.database;
    int result =
        await db.rawDelete('DELETE FROM $wordTable WHERE $colId = $id');
    return result;
  }

  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $wordTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<Word>> getWordList() async {
    var wordMapList = await getWordMapList();
    int count = wordMapList.length;
    List<Word> noteList = List<Word>();
    for (int i = 0; i < count; i++) {
      noteList.add(Word.fromJson(wordMapList[i]));
    }
    return noteList;
  }

  Future<List<Word>> asd(int slcAvg) async {
    Database db = await this.database;
    var wordMapList = await db.rawQuery(
        "SELECT * FROM $wordTable WHERE avgAnswer<$slcAvg or totalAnswer==0");
    int count = wordMapList.length;
    List<Word> noteList = List<Word>();
    for (int i = 0; i < count; i++) {
      noteList.add(Word.fromJson(wordMapList[i]));
    }
    return noteList;
  }
}
