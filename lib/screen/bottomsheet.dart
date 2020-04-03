import 'package:flutter/material.dart';
import 'package:wordandmemory/model/word.dart';
import 'package:wordandmemory/utils/DataBaseHelper.dart';
import 'package:wordandmemory/widgets/customTextField.dart';

class BottomSheet extends StatefulWidget {
  @override
  _BottomSheetState createState() => _BottomSheetState();

  final Word w;

  BottomSheet(this.w);
}

class _BottomSheetState extends State<BottomSheet> {
  DatabaseHelper dbHelper = DatabaseHelper();
  TextEditingController _tecTr;
  TextEditingController _tecEn;
  TextEditingController _tecSentenceTr;
  TextEditingController _tecSentenceEn;

  @override
  void initState() {
    super.initState();
    _tecTr = TextEditingController();
    _tecEn = TextEditingController();
    _tecSentenceTr = TextEditingController();
    _tecSentenceEn = TextEditingController();
    _tecEn.text = widget.w.en;
    _tecTr.text = widget.w.tr;
    _tecSentenceEn.text = widget.w.sentenceEn;
    _tecSentenceTr.text = widget.w.sentenceTr;
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
    return Container(
      color: Color.fromRGBO(58, 66, 86, 1.0),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              CTextField("TR", widget.w.tr, _tecTr),
              CTextField("EN", widget.w.en, _tecEn),
              CTextField("EN Sentence", widget.w.sentenceEn, _tecSentenceEn),
              CTextField("TR Cümle", widget.w.sentenceTr, _tecSentenceTr),
              Container(
                color: Color.fromRGBO(58, 66, 86, 1.0),
                alignment: Alignment.center,
                child: Text(
                  "Toplam sorulma : " +
                      // widget.w.wrongAnswer
                      (widget.w.correctAnswer).toString() +
                      " Doğru: " +
                      widget.w.correctAnswer.toString(),
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ButtonTheme(
                    buttonColor: Color.fromRGBO(64, 75, 96, .9),
                    minWidth: 125.0,
                    height: 35.0,
                    child: RaisedButton(
                      onPressed: () => Update(widget.w),
                      child: Text(
                        "Güncelle",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  ButtonTheme(
                    buttonColor: Color.fromRGBO(64, 75, 96, .9),
                    minWidth: 125.0,
                    height: 35.0,
                    child: RaisedButton(
                      onPressed: () => Delete(widget.w.id),
                      child: Text(
                        "Sil",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future Delete(int id) async {
    int result = await dbHelper.deleteWord(id);
    if (result != 0) {
      showAlertDialog('Durum', 'Kelime listenizden silindi.');
      Navigator.pushNamed(context, '/listword');
    } else {
      showAlertDialog('Durum', 'Silme işlemi başarız.');
    }
  }

  Future Update(Word w) async {
    w.tr = _tecTr.text;
    w.en = _tecEn.text;
    w.sentenceEn = _tecSentenceEn.text;
    w.sentenceTr = _tecSentenceTr.text;
    int result = await dbHelper.updateWord(w);
    if (result != 0) {
      Navigator.pushNamed(context, '/listword');
    } else {
      showAlertDialog("Durum", "Kelime güncellenemedi");
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
