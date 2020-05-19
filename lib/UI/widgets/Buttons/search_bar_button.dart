
import 'package:flutter/material.dart';

class SearchBarButton extends StatelessWidget {
  const SearchBarButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      onPressed: () {
        showSearch();
      },
      borderSide: BorderSide(
        style: BorderStyle.solid,
        color: Colors.white54,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      padding: EdgeInsets.all(30.0),
      child: Text("Search Data", style: TextStyle(color: Colors.white70),),
    );
  }
}