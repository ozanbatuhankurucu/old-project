import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wordandmemory/model/word.dart';
import 'package:wordandmemory/screen/testEnd.dart';
import 'package:wordandmemory/utils/DataBaseHelper.dart';
import 'package:wordandmemory/utils/quiz.dart';
import 'package:wordandmemory/widgets/customTestButton.dart';

class TestWord extends StatefulWidget {
  final List<Word> wordList;

  TestWord(this.wordList);

  @override
  _TestWord createState() => _TestWord();
}

class _TestWord extends State<TestWord> {
  int _cQNumber = 1;
  int _qLenght;
  List<Word> wrongWords;
  DatabaseHelper dbHelper = DatabaseHelper();
  List<Widget> buttons;
  String currentQString;
  Quiz quiz;
  List<Word> wordList;
  Question currentQuestion;
  int _start = 1;
  bool blockOverClick;

  @override
  void initState() {
    super.initState();
    wordList = widget.wordList;
    buttons = List<Widget>();
    wrongWords = List<Word>();
    quiz = Quiz(wordList);
    blockOverClick = true;
    createFirstQuestion();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void createFirstQuestion() {
    currentQuestion = quiz.nextQuestion;
    currentQString = currentQuestion.word.tr;
    _qLenght = wordList.length;
    prepareAnswerButtom();
  }

  void prepareAnswerButtom() {
    buttons.clear();
    buttons.add(CTestButton(currentQuestion.choices[0], () {
      handlerAnswer(currentQuestion.choices[0], 0);
    }, 0));
    buttons.add(
      CTestButton(currentQuestion.choices[1], () {
        handlerAnswer(currentQuestion.choices[1], 1);
      }, 0),
    );
    buttons.add(CTestButton(currentQuestion.choices[2], () {
      handlerAnswer(currentQuestion.choices[2], 2);
    }, 0));
    buttons.add(CTestButton(currentQuestion.choices[3], () {
      handlerAnswer(currentQuestion.choices[3], 3);
    }, 0));
  }

  void handlerAnswer(String ans, int index) {
    if (!blockOverClick) return;
    blockOverClick = false;
    int total, correct, avg;
    total = currentQuestion.word.totalAnswer;
    correct = currentQuestion.word.correctAnswer;
    if (quiz.isCorrect(ans)) {
      setState(() {
        buttons[index] = CTestButton(currentQuestion.choices[index], () {
          handlerAnswer(currentQuestion.choices[index], index);
        }, 1);
      });
      correct++;
    } else {
      setState(() {
        buttons[index] = CTestButton(currentQuestion.choices[index], () {
          handlerAnswer(currentQuestion.choices[index], index);
        }, -1);
      });
      wrongWords.add(currentQuestion.word);
    }
    total++;
    avg = ((correct / total) * 100).round();
    currentQuestion.word.correctAnswer = correct;
    currentQuestion.word.totalAnswer = total;
    currentQuestion.word.avgAnswer = avg;

    dbHelper.updateWord(currentQuestion.word);
    startTimer();
  }

  void startTimer() {
    const oneSec = const Duration(milliseconds: 750);
    Timer.periodic(
      oneSec,
      (Timer timer) => setState(
            () {
              if (_start < 1) {
                timer.cancel();
                _start = 1;
                currentQuestion = quiz.nextQuestion;
                if (currentQuestion == null) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TestEnd(wrongWords)));
                  return;
                }
                currentQString = currentQuestion.word.tr;
                _cQNumber++;
                prepareAnswerButtom();
              } else {
                _start = _start - 1;
              }
            },
          ),
    );
    blockOverClick = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        title: Text("Ezber Test Et"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.center,
                  child: Text("$currentQString",
                      style: TextStyle(fontSize: 24.0, color: Colors.white)),
                )),
            Expanded(
              flex: 1,
              child: Container(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(children: this.buttons),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
