
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'selected_topic.dart';



class TopicSearch extends StatefulWidget {
  @override
  _TopicSearchState createState() => _TopicSearchState();
}

class _TopicSearchState extends State<TopicSearch> {
  List<String> items = List<String>();
  TextEditingController controller = new TextEditingController();
  String filter;

  @override
  initState() {
    super.initState();
    items.add("Time is The Most Precious Commodity");
    items.add("No Excuses");
    items.add("Take The Initiative");
    items.add("Your Word is Worth More Than Gold");
    items.add("Seek To Add Value");
    items.add("Compete or Collaborate");
    items.add("So You Want To Get Into Music");
    items.add("Battling Insecurity");
    items.add("Overlooked Hardships of Fatherhood");
    items.add("How Do I Love Myself");
    items.add("Overlooked Hardships of Motherhood");
    items.add("Forgiving Yourself");
    items.add("Favorite Traditions");
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
                                  SelectedTopicScreen(topic: items[index]),
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
