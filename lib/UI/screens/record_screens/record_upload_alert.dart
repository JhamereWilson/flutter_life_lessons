import 'package:flutter/material.dart';

class RecordUploadAlert extends StatelessWidget {
  TextEditingController _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('TextField in Dialog'),
      content: TextField(
        controller: _textFieldController,
        decoration: InputDecoration(hintText: "What's the name of this lesson?"),
      ),
      actions: <Widget>[
          FlatButton(
          child: Text('SUBMIT'),
          onPressed: () {
          
          },
        ),
         FlatButton(
          child: new Text('CANCEL'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
