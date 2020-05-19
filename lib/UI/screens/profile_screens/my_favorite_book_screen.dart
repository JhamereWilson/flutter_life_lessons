import 'package:flutter/material.dart';

class MyFavoriteBookScreen extends StatelessWidget {
 

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 70),
        Icon(Icons.filter_none, color: Colors.black26,),
            SizedBox(height: 20),
        Text("Uh oh, don't have any favorited lessons!", style: TextStyle(color: Colors.black26, fontSize: 16.0),),
            SizedBox(height: 20),
        Text("To favorite a lesson, tap on a lesson you enjoy and select the option 'Add to Favorites'", style: TextStyle(color: Colors.black26, fontSize: 16.0), textAlign: TextAlign.center,),
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
            child: Text("Listen and favorite a lesson!", style: TextStyle(color: Colors.white),),
          ),
        ),
      
      ],
    );
  }
}