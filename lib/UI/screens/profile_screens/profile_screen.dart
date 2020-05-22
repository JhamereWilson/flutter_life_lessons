import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutter_life/Data/user_repository.dart';
import 'package:firebase_flutter_life/Models/models.dart';
import 'package:firebase_flutter_life/Pickers/user_image_picker.dart';
import 'package:firebase_flutter_life/UI/screens/settings_screen.dart';

import 'package:firebase_flutter_life/UI/widgets/book_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
   File _userImageFile;

     void _pickedImage(File image) {
    _userImageFile = image;
  }

  @override
  void initState() { 
    super.initState();
    getCurrentUser();
  }

  getCurrentUser() async {
    var currentUser = await FirebaseAuth.instance.currentUser();
    return UserRepository().usersRef.document(currentUser.uid);
  }

  buildProfileHeader() async {
    
    return FutureBuilder(
      future: getCurrentUser(),
      builder: (context, snapshot) {
           if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          User user = User.fromDocument(snapshot.data);
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
                          color: Colors.white70,
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
                      backgroundImage:
                          NetworkImage(user.profileImageUrl),
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
      }
    );
  }

  toggleBookView() {
    return ToggleLessonView();
  }

  buildProfileScreen() {
    return Container(
      color: Colors.white24,
      child: ListView(
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
