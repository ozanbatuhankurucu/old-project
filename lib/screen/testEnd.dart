import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:wordandmemory/model/word.dart';

class TestEnd extends StatelessWidget {
  List<Word> wrongWords;

  TestEnd(this.wrongWords);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Material(
        color: Color.fromRGBO(58, 66, 86, 1.0),
        child: Container(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Yanlış yaptığınız kelimeler',
                            style:
                                TextStyle(color: Colors.white, fontSize: 20.0)),
                        Text('Doğru cevaplar için dokun',
                            style: TextStyle(color: Colors.white))
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    child: ListView.builder(
                      itemCount: wrongWords.length,
                      itemBuilder: (context, i) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Container(
                            height: 50.0,
                            child: FlipCard(
                              direction: FlipDirection.HORIZONTAL, // default
                              front: Container(
                                color: Colors.grey,
                                alignment: Alignment.center,
                                child: Text(wrongWords[i].en,
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold)),
                              ),
                              back: Container(
                                color: Colors.grey,
                                alignment: Alignment.center,
                                child: Text(wrongWords[i].tr,
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/');
                  },
                  child: Container(
                      color: Colors.grey,
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 30.0,
                      child: Text('Anasayfaya dön',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold))),
                )
              ],
            )),
      ),
    );
  }
}
