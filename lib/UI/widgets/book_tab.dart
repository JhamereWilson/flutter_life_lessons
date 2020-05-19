

import 'package:firebase_flutter_life/UI/screens/profile_screens/my_favorite_book_screen.dart';
import 'package:firebase_flutter_life/UI/screens/profile_screens/my_private_book_view.dart';
import 'package:firebase_flutter_life/UI/screens/profile_screens/my_public_book_view.dart';
import 'package:flutter/material.dart';

class ToggleLessonView extends StatefulWidget {
  @override
  _ToggleLessonViewState createState() => _ToggleLessonViewState();
}

class _ToggleLessonViewState extends State<ToggleLessonView>
    with TickerProviderStateMixin {
  List<Tab> tabList = List();
  TabController _tabController;

  @override
  void initState() {
    tabList.add(Tab(
      text: 'Public',
      icon: Icon(Icons.public),
    ));
    tabList.add(Tab(
      text: 'Private',
      icon: Icon(Icons.lock_outline),
    ));
    tabList.add(Tab(
      text: 'Favorite',
      icon: Icon(Icons.favorite_border),
    ));
    super.initState();
    _tabController = TabController(vsync: this, length: tabList.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            constraints: BoxConstraints.expand(height: 60),
            child: TabBar(
              controller: _tabController,
              unselectedLabelColor: Colors.grey[300],
              labelColor: Colors.white,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(18.0),
                gradient: LinearGradient(
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                  colors: <Color>[
                    Colors.lightGreen[200],
                    Colors.lightBlue[600],
                  ],
                ),
              ),
              tabs: tabList,
            ),
          ),
          Expanded(
            child: Container(
              height: 50,
              child: TabBarView(
                controller: _tabController,
                children: <Widget>[
                  MyPublicBookScreen(),
                  MyPrivateBookScreen(),
                  MyFavoriteBookScreen(),
                ],
              ),
            ),
          ),
      
        ],
      ),
    );
  }
}
