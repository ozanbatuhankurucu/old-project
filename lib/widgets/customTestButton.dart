import 'package:flutter/material.dart';

class CTestButton extends StatelessWidget {
  final String _answer;
  final VoidCallback _ontap;
  final int state;
  Color c;

  CTestButton(this._answer, this._ontap, this.state);

  @override
  Widget build(BuildContext context) {
    if (state == -1)
      c = Colors.redAccent;
    else if (state == 0)
      c = Colors.grey;
    else
      c = Colors.greenAccent;

    return Padding(
      padding: EdgeInsets.only(bottom: 8.0),
      child: RaisedButton(
        onPressed: _ontap,
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.only(
                topRight: Radius.circular(25),
                bottomRight: Radius.circular(25))),
        textColor: Colors.white,
        color: c,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text("$_answer"),
            Icon(
              Icons.play_arrow,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
