import 'package:flutter/material.dart';

class CHomeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/listword');
      },
      child: Container(
        width: 130,
        height: 130,
        decoration: BoxDecoration(
          border: new Border.all(
              color: Color.fromRGBO(64, 75, 96, .9),
              width: 5.0,
              style: BorderStyle.solid),
          color: Color.fromRGBO(64, 75, 96, .9),
          borderRadius: new BorderRadius.all(new Radius.circular(20.0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.format_list_numbered,
              color: Colors.white,
            ),
            Text(
              "Listeyi Gör",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0),
            ),
          ],
        ),
      ),
    );
  }
}
