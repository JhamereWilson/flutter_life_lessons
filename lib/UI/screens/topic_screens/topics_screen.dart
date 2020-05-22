
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'topic_search.dart';

class TopicsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
              colors: <Color>[
                Colors.lightGreen[200],
                Colors.lightBlue[600],
              ],
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            extendBodyBehindAppBar: true,
            appBar: AppBar(title: Text("life lessons", style: TextStyle(color: Colors.white, fontSize: 24.0),), backgroundColor: Colors.transparent, elevation: 0, centerTitle: true,),
            body: TopicSearch(),
          ),
        );
        
  }

  Widget getTopicScreenUI() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 18, right: 16),
      child: Container(
        height: 70,
        width: 70,
      ),
    );
  }
}
