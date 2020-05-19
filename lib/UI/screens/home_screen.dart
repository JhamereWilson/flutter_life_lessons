
import 'package:firebase_flutter_life/Models/models.dart';


import 'package:firebase_flutter_life/UI/screens/screens.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'profile_screens/profile_screen.dart';
import 'record_screens/record_begin_screen.dart';
import 'topic_screens/topics_screen.dart';






class HomeScreen extends StatefulWidget {
  final User user;

  HomeScreen({Key key, this.user}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController pageController;
  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  onPageChanged(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  onTap(int pageIndex) {
    pageController.animateToPage(
      pageIndex,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: <Widget>[
          TopicsScreen(),
          RecordBeginScreen(),
          ProfileScreen(),
        ],
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageIndex,
        onTap: onTap,
        selectedItemColor: Colors.grey[800],
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              title: Text("Home")),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.mic,
                size: 35.0,
              ),
              title: Text("Record")),
          BottomNavigationBarItem(
              icon: Icon(Icons.book), title: Text("My Book")),
        ],
      ),
    );
  }
}
