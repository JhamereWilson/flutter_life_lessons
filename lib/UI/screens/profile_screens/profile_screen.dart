import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutter_life/Data/user_repository.dart';
import 'package:firebase_flutter_life/Models/models.dart';
import 'package:firebase_flutter_life/Pickers/user_image_picker.dart';
import 'package:firebase_flutter_life/UI/screens/settings_screen.dart';

import 'package:firebase_flutter_life/UI/widgets/book_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  final User currentUser;

  const ProfileScreen({Key key, this.currentUser}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
 

  buildProfileHeader() {
    return FutureBuilder(
        future:
            UserRepository().usersRef.document(widget.currentUser.userID).get(),
        builder: (context, futureSnapshot) {
          if (futureSnapshot.connectionState == ConnectionState.waiting) {
            return skeletonHeader();
          }
          User user = User.fromDocument(futureSnapshot.data);
          print("USER: $user");
          return Container(
            height: 320,
            width: double.infinity,
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(60),
                      bottomRight: Radius.circular(60),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.bottomRight,
                      end: Alignment.topLeft,
                      colors: <Color>[
                        Colors.lightGreen[200],
                        Colors.lightBlue[600],
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.inbox),
                            color: Colors.transparent,
                            onPressed: () {},
                          ),
                          Text(
                            "Your Book",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w300),
                          ),
                          AppDrawerButton(),
                        ],
                      ),
                      SizedBox(height: 20),
                      CircleAvatar(
                        radius: 40.0,
                        backgroundColor: Colors.grey,
                        backgroundImage: NetworkImage(user.profileImageUrl),
                      ),
                      SizedBox(height: 10),
                      Text(
                        user.username,
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.location_on,
                            color: Colors.white70,
                            size: 12,
                          ),
                          Text("Washington, D.C.",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300)),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text("1234",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                              Text("Audience",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300)),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Text("134",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                              Text("Classmates",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300)),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Text("120",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                              Text("Lessons",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300))
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  skeletonHeader() { // Skeleton Header while connecting to network
    return Container(
      height: 320,
      width: double.infinity,
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(60),
                bottomRight: Radius.circular(60),
              ),
              gradient: LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
                colors: <Color>[
                  Colors.lightGreen[200],
                  Colors.lightBlue[600],
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.inbox),
                      color: Colors.transparent,
                      onPressed: () {},
                    ),
                    Text(
                      "Your Book",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w300),
                    ),
                    AppDrawerButton(),
                  ],
                ),
                SizedBox(height: 20),
                CircleAvatar(
                  radius: 40.0,
                  backgroundColor: Colors.grey,
                ),
                SizedBox(height: 10),
                Container(
                  width: 10,
                  color: Colors.white70,
                ),
                SizedBox(height: 5),
                Container(
                  width: 10,
                  color: Colors.white70,
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
              Container(
                  width: 10,
                  color: Colors.white70,
                ),
                 Container(
                  width: 10,
                  color: Colors.white70,
                ),
                  Container(
                  width: 10,
                  color: Colors.white70,
                ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  toggleBookView() {
    return ToggleLessonView();
  }

  buildProfileScreen() {
    return Container(
      color: Colors.white24,
      child: Column(
        children: <Widget>[
          buildProfileHeader(),
          SizedBox(height: 10),
          toggleBookView()
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildProfileScreen();
  }
}

class AppDrawerButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.settings),
      color: Colors.white70,
      onPressed: () {
        var appDrawerRoute = MaterialPageRoute(
          builder: (BuildContext context) => AppDrawer(),
        );
        Navigator.of(context).push(appDrawerRoute);
      },
    );
  }
}
