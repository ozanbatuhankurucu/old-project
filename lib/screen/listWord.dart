import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wordandmemory/model/word.dart';
import 'package:wordandmemory/screen/addWord.dart';
import 'package:wordandmemory/utils/DataBaseHelper.dart';

class ListWord extends StatefulWidget {
  @override
  _ListWordState createState() => _ListWordState();
}

class _ListWordState extends State<ListWord> {
  DatabaseHelper dbHelper = DatabaseHelper();

  List<Word> wordList;
  double wpercent, cpercent, isNothing;
  @override
  void initState() {
    super.initState();
    wordList = List<Word>();
    loadWordList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(title: Text("Kelime ve Cümleler ")),
      body: Padding(
          padding: EdgeInsets.all(8.0),
          child: wordList.length != 0
              ? ListView.builder(
                  itemCount: wordList.length,
                  itemBuilder: (context, i) {
                    final Word w = wordList[i];
                    isNothing = 0;
                    if (w.totalAnswer != 0) {
                      wpercent =
                          ((w.totalAnswer - w.correctAnswer) / w.totalAnswer) *
                              100;
                      cpercent = (w.correctAnswer / w.totalAnswer) * 100;
                      print(wpercent);
                      print(cpercent);
                    } else {
                      wpercent = 0;
                      cpercent = 0;
                      isNothing = 100;
                    }

                    return Dismissible(
                        key: ObjectKey(w),
                        onDismissed: (direction) {
                          if (DismissDirection.endToStart == direction) {
                            setState(() {
                              dbHelper.deleteWord(w.id);
                              wordList.removeAt(i);
                            });
                          } else {
                            return;
                          }
                        },
                        background: Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Container(
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.only(right: 20.0),
                            color: Colors.red,
                            child: Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        child: Padding(
                            padding: EdgeInsets.only(bottom: 8.0),
                            child: Container(
                              color: Colors.white,
                              child: ExpansionTile(
                                title: Text("" + w.en,
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold)),
                                children: <Widget>[
                                  Container(
                                      padding: EdgeInsets.all(15.0),
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              AnimatedCircularChart(
                                                size: Size(100.0, 100.0),
                                                initialChartData: <
                                                    CircularStackEntry>[
                                                  CircularStackEntry(
                                                    <CircularSegmentEntry>[
                                                      CircularSegmentEntry(
                                                        cpercent,
                                                        Colors.greenAccent,
                                                        rankKey: 'correct',
                                                      ),
                                                      CircularSegmentEntry(
                                                        wpercent,
                                                        Colors.redAccent,
                                                        rankKey: 'wrong',
                                                      ),
                                                      CircularSegmentEntry(
                                                        isNothing,
                                                        Colors.grey,
                                                        rankKey: 'nothing',
                                                      ),
                                                    ],
                                                    rankKey: 'progress',
                                                  ),
                                                ],
                                                chartType:
                                                    CircularChartType.Radial,
                                                percentageValues: true,
                                                holeLabel: '%' +
                                                    w.avgAnswer.toString(),
                                                labelStyle: TextStyle(
                                                  color: Colors.blueGrey[600],
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16.0,
                                                ),
                                              ),
                                              Expanded(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text("" + w.tr,
                                                        style: TextStyle(
                                                            fontSize: 16.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    Text("" + w.sentenceEn,
                                                        style: TextStyle(
                                                            fontSize: 14.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    Text("" + w.sentenceTr,
                                                        style: TextStyle(
                                                            fontSize: 14.0)),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          Container(
                                            alignment: Alignment.centerRight,
                                            child: GestureDetector(
                                              child: Text("Düzenle",
                                                  style: TextStyle(
                                                      color: Colors.blue[300])),
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        AddWord(w),
                                                  ),
                                                );
                                              },
                                            ),
                                          )
                                        ],
                                      ))
                                ],
                              ),
                            )));
                  },
                )
              : Container(
                  alignment: Alignment.center,
                  child: Text('Hiç kelime ekli değil.',
                      style: TextStyle(fontSize: 16.0, color: Colors.white)),
                )),
    );
  }

  void loadWordList() {
    final Future<Database> dbFuture = dbHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Word>> wordlistfuture = dbHelper.getWordList();
      wordlistfuture.then((wordlist) {
        setState(() {
          this.wordList = wordlist;
        });
      });
    });
  }
}
