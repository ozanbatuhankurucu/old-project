import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wordandmemory/model/word.dart';
import 'package:wordandmemory/screen/testWord.dart';
import 'package:wordandmemory/utils/DataBaseHelper.dart';

class TestPrepare extends StatefulWidget {
  @override
  _TestPrepare createState() => _TestPrepare();
}

class _TestPrepare extends State<TestPrepare> {
  DatabaseHelper dbHelper = DatabaseHelper();
  List<Word> wordList;
  String dropdownValue;
  int sliderValue;

  @override
  void initState() {
    super.initState();
    wordList = List<Word>();
    loadWordList();
    sliderValue = 0;
    dropdownValue = "1 gün";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Testi Hazırla",
        ),
      ),
      body: Container(
          padding: EdgeInsets.all(8.0),
          color: Color.fromRGBO(64, 75, 96, .9),
          child: Column(
            children: <Widget>[
              Container(
                color: Colors.white,
                child: ExpansionTile(
                  title: Text("Başarıya Göre"),
                  children: <Widget>[
                    Slider(
                      min: 0.0,
                      max: 100.0,
                      divisions: 100,
                      value: sliderValue.toDouble(),
                      activeColor: Color.fromRGBO(64, 75, 96, .9),
                      inactiveColor: Colors.grey[100],
                      onChanged: (newValue) {
                        setState(() {
                          sliderValue = newValue.round();
                        });
                      },
                    ),
                    Text("Başarı orarı %$sliderValue den az keliemler.",
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold)),
                    RaisedButton(
                      onPressed: () {
                        loadWordList();
                        if (wordList.length < 4)
                          showAlertDialog("Sınav hazırlanamadı",
                              "Sınav hazırlamak için en az 4 kelime eklemelisiniz.");
                        else
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TestWord(wordList)));
                      },
                      child: Text("Sınavı başlat"),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Container(
                color: Colors.white,
                child: ExpansionTile(
                  title: Text("Zamana Göre"),
                  children: <Widget>[
                    DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: dropdownValue,
                        hint: Text("1 gün"),
                        onChanged: (String newValue) {
                          setState(() {
                            dropdownValue = newValue;
                          });
                        },
                        items: <String>[
                          '1 gün',
                          '2 gün',
                          '1 hafta',
                          '2 hafta',
                          '1 ay'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                    Text("Son " + dropdownValue + " eklenen kelimeler",
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold)),
                    RaisedButton(
                      child: Text("Sınavı Başlat"),
                      onPressed: () {},
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }

  void loadWordList() {
    print(sliderValue);
    final Future<Database> dbFuture = dbHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Word>> wordlistfuture = dbHelper.asd(sliderValue);
      wordlistfuture.then((wordlist) {
        setState(() {
          wordList = wordlist;
        });
      });
    });
  }

  Future showAlertDialog(String title, String message) async {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }
}
