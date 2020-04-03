import 'package:flutter/material.dart';
import 'package:wordandmemory/model/word.dart';
import 'package:wordandmemory/utils/DataBaseHelper.dart';
import 'package:wordandmemory/widgets/customTextField.dart';

class AddWord extends StatefulWidget {
  final Word w;

  AddWord(this.w);
  @override
  _AddWord createState() => _AddWord(w);
}

class _AddWord extends State<AddWord> {
  final Word w;
  _AddWord(this.w);
  DatabaseHelper dbHelper = DatabaseHelper();
  TextEditingController _tecTr;
  TextEditingController _tecEn;
  TextEditingController _tecSentenceTr;
  TextEditingController _tecSentenceEn;

  @override
  void initState() {
    super.initState();
    _tecTr = TextEditingController(text: w == null ? "" : w.tr);
    _tecEn = TextEditingController(text: w == null ? "" : w.en);
    _tecSentenceTr = TextEditingController(text: w == null ? "" : w.sentenceTr);
    _tecSentenceEn = TextEditingController(text: w == null ? "" : w.sentenceEn);
  }

  @override
  void dispose() {
    _tecTr.dispose();
    _tecEn.dispose();
    _tecSentenceTr.dispose();
    _tecSentenceEn.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Kelime Ekle",
        ),
      ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, 1.0)),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CTextField("Türkçe Kelime", "Türkçe kelime giriniz.", _tecTr),
              CTextField(
                  "English Word", "Please enter the English word", _tecEn),
              CTextField("English Sentence",
                  "Please enter the English sentence ", _tecSentenceEn),
              CTextField(
                  "Türkçe Cümle", "Türkçe cümle giriniz.", _tecSentenceTr),
              RaisedButton(
                child: Text(w == null ? "Ekle" : "Güncelle"),
                onPressed: () => w == null ? addWord() : uptadeWord(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future uptadeWord() async {
    w.tr = _tecTr.text;
    w.en = _tecEn.text;
    w.sentenceEn = _tecSentenceEn.text;
    w.sentenceTr = _tecSentenceTr.text;
    int rid = await dbHelper.updateWord(w);
    if (rid != 0) {
      // Success
      Navigator.pushNamed(context, "/listword");
      showAlertDialog('Durum', 'Kelime güncellendi.');
    } else {
      // Failure
      showAlertDialog('Durum', 'Kelime güncellenemedi.');
    }
  }

  Future addWord() async {
    String createdTime;
    if (DateTime.now().day < 10)
      createdTime = DateTime.now().year.toString() +
          "" +
          DateTime.now().month.toString() +
          "0" +
          DateTime.now().day.toString();
    else
      createdTime = DateTime.now().year.toString() +
          "" +
          DateTime.now().month.toString() +
          "" +
          DateTime.now().day.toString();
    Word w = new Word(
        _tecTr.text,
        _tecEn.text,
        _tecSentenceEn.text == "" ? "Nothing" : _tecSentenceEn.text,
        _tecSentenceTr.text == "" ? "boş" : _tecSentenceTr.text,
        createdTime,
        0,
        0,
        0);

    int rid = await dbHelper.insertWord(w);
    if (rid != 0) {
      // Success
      Navigator.pop(context);
      showAlertDialog('Durum', 'Kelime listeye eklendi.');
    } else {
      // Failure
      showAlertDialog('Durum', 'Kelime ekleme başarız.');
    }
  }

  Future showAlertDialog(String title, String message) async {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }
}
