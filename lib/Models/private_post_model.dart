import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutter_life/Data/posts_repository.dart';
import 'package:firebase_flutter_life/Data/user_repository.dart';
import 'package:firebase_flutter_life/Models/models.dart';
import 'package:firebase_flutter_life/Services/audio_service.dart';
import 'package:firebase_flutter_life/UI/screens/home_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PrivatePost extends StatefulWidget {
  final String title;
  final String topic;
  final String postID;
  final String userID;
  final String recordingURL;
  final String username;
  final String userImage;

  PrivatePost({
    @required this.title,
    @required this.topic,
    @required this.postID,
    @required this.userID,
    @required this.recordingURL,
    @required this.username,
    @required this.userImage,
  });

  factory PrivatePost.fromDocument(DocumentSnapshot doc) {
    return PrivatePost(
      title: doc["title"],
      topic: doc["topic"],
      postID: doc["postID"],
      userID: doc["userID"],
      recordingURL: doc["recordingURL"],
      username: doc["username"],
      userImage: doc["userImage"],
    );
  }
  @override
  _PrivatePostState createState() => _PrivatePostState(
        title: this.title,
        topic: this.topic,
        postID: this.postID,
        userID: this.userID,
        recordingURL: this.recordingURL,
        username: this.username,
        userImage: this.userImage,
      );
}

class _PrivatePostState extends State<PrivatePost> {
  final String title;
  final String topic;
  final String postID;
  final String userID;
  final String recordingURL;
  final String username;
  final String userImage;
  bool showHeart = false;
  bool isLiked;
  int likeCount;
  bool isPlaying = false;

  _PrivatePostState({
    this.title,
    this.topic,
    this.postID,
    this.userID,
    this.recordingURL,
    this.username,
    this.userImage,
    this.likeCount,
  });

  buildPostHeader() {
    return FutureBuilder(
        future: UserRepository().usersRef.document(userID).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircleAvatar(
              backgroundColor: Colors.grey,
            );
          }
          User user = User.fromDocument(snapshot.data);

          return CircleAvatar(
            backgroundImage: NetworkImage(user.profileImageUrl),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          AudioService().play(recordingURL);
          setState(() {
            isPlaying = true;
          });
        },
        child: Card(
          color: isPlaying ? Colors.black12 : Colors.white,
          margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
          child: ListTile(
            leading: buildPostHeader(),
            title: Text(title),
            subtitle: Text(username),
          ),
        ),
      ),
    );
  }
}
