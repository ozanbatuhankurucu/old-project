import 'package:flutter/material.dart';
import 'package:wordandmemory/screen/home_yedek.dart';
import 'package:wordandmemory/screen/testPrepare.dart';
import 'screen/addWord.dart';
import 'screen/listWord.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => HomePage(),
      '/addword': (context) => AddWord(null),
      '/listword': (context) => ListWord(),
      '/test': (context) => TestPrepare(),
    },
    debugShowCheckedModeBanner: false,
    title: "Kelime Ezberle",
    theme: ThemeData(primaryColor: Color.fromRGBO(58, 66, 86, 1.0)),
  ));
}
