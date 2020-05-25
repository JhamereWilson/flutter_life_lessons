import 'package:firebase_flutter_life/UI/screens/topic_screens/topic_selected_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'selected_topic.dart';

class ArchivedTopics extends StatefulWidget {
  @override
  _ArchivedTopicsState createState() => _ArchivedTopicsState();
}

class _ArchivedTopicsState extends State<ArchivedTopics> {
  List<String> items = List<String>();
  TextEditingController controller = new TextEditingController();
  String filter;

  @override
  initState() {
    super.initState();
    items.add("Battling Insecurity");
    items.add("Despite The Odds...");
    items.add("How To Love Myself");
    items.add("Overlooked Hardships of Motherhood");
    items.add("Forgiving Yourself");
    items.add("Favorite Traditions");
    items.add("So You Want A Career in Music");
    controller.addListener(() {
      setState(() {
        filter = controller.text;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

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
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        color: Colors.blueGrey,
                        child: ListTile(
                          onTap: () {
                            var learnRoute = MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  TopicSelectedScreen(topic: items[index]),
                            );
                            Navigator.of(context).push(learnRoute);
                          },
                          title: Text(
                            items[index],
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontFamily: "Montserrat"),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}

//  TextField(
//                 controller: editingController,
//                 decoration: InputDecoration(
//                     labelText: "Discover Topics",
//                     hintText: "Search",
//                     prefixIcon: Icon(Icons.search),
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(25.0)))),
//               );
