import 'package:flutter/material.dart';

class MyPublicBookScreen extends StatelessWidget {
 

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 70),
        Icon(Icons.filter_none, color: Colors.black26,),
            SizedBox(height: 20),
        Text("Uh oh, you don't have any lessons!", style: TextStyle(color: Colors.black26, fontSize: 16.0),),
            SizedBox(height: 20),
        Text("Get started and record a new lesson today!", style: TextStyle(color: Colors.black26, fontSize: 16.0)),
            SizedBox(height: 20),
        SizedBox(
          height: 50,
          width: 250,
                  child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
            color: Colors.indigo[300],
            onPressed: (){},
            child: Text("Record your first lesson!", style: TextStyle(color: Colors.white),),
          ),
        ),
      
      ],
    );
  }
}