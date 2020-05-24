import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutter_life/Models/topics.dart.dart';

import 'package:flutter/material.dart';

import 'record_screen.dart';
import 'test_record_screen.dart';





class RecordBeginScreen extends StatefulWidget {
  @override
  _RecordBeginScreenState createState() => _RecordBeginScreenState();
}

class _RecordBeginScreenState extends State<RecordBeginScreen> {



  var recordingTopic = "Select a Topic";
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.bottomRight,
        end: Alignment.topLeft,
        colors: <Color>[
          Colors.lightGreen[200],
          Colors.lightBlue[600],
        ],
      ),),
      child: Column(
        children: <Widget>[
          SizedBox(height: 50),
          Container(
            height: 100,
              child: Text(
            recordingTopic,
            style: TextStyle(
                color: Colors.white,
                fontSize: 30.0,
                fontWeight: FontWeight.w200),
            textAlign: TextAlign.center,
          )),
          SizedBox(height: 100),
          Container(
            padding: EdgeInsets.all(2.0),
            color: Colors.white12,
            height: 100,
            child: ListWheelScrollView(
              itemExtent: 50.0,
              useMagnifier: true,
              magnification: 1.5,
              renderChildrenOutsideViewport: false,
              clipToSize: false,
              children: Topics,
              perspective: 0.005,
              diameterRatio: 1.25,
              onSelectedItemChanged: (index) => {
                setState(() {
                  recordingTopic = Topics[index].data;
                })
              },
            ),
          ),
          SizedBox(height: 50),
          SizedBox(
            height: 40,
            width: 200,
                      child: FlatButton(
              color: Colors.blueGrey[400],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
                //side: BorderSide(color: Colors.white)
              ), onPressed: () {
                var learnRoute = MaterialPageRoute(
                          builder: (BuildContext context) =>
                              TestRecord(topic:recordingTopic),
                        );
                        Navigator.of(context).push(learnRoute);
              },
              child: Text("Go to Recording Page", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),),
              
            ),
          ),

        ],
      ),
    );
  }
}
