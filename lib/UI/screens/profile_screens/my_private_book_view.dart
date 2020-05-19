import 'package:flutter/material.dart';

class MyPrivateBookScreen extends StatelessWidget {
 

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 70),
        Icon(Icons.filter_none, color: Colors.black26,),
            SizedBox(height: 20),
        Text("It looks like you haven't started your private book yet.", style: TextStyle(color: Colors.black26, fontSize: 16.0),),
            SizedBox(height: 20),
        Text("To start a private book, record a lesson and select the option 'add to private book' ", style: TextStyle(color: Colors.black26, fontSize: 16.0), textAlign: TextAlign.center,),
            SizedBox(height: 30),
        SizedBox(
          height: 50,
          width: 250,
                  child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
            color: Colors.indigo[300],
            onPressed: (){},
            child: Text("Record your first private lesson!", style: TextStyle(color: Colors.white),textAlign: TextAlign.center,),
          ),
        ),
      
      ],
    );
  }
}