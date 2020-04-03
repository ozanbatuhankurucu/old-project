import 'package:flutter/material.dart';

class CTextField extends StatelessWidget {
  TextEditingController _textEditingController;
  String _labelText, _hintText;

  CTextField(this._labelText, this._hintText, this._textEditingController);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: TextField(
        keyboardType: TextInputType.text,
        controller: _textEditingController,
        decoration: InputDecoration(
            hintText: "$_hintText",
            hintStyle: TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
            labelText: "$_labelText",
            labelStyle: TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
            errorStyle: TextStyle(
              color: Colors.white,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
            filled: true,
            fillColor: Color.fromRGBO(64, 75, 96, .9)),
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
