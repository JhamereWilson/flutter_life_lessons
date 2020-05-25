import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutter_life/Data/posts_repository.dart';
import 'package:firebase_flutter_life/Data/user_repository.dart';
import 'package:firebase_flutter_life/Models/models.dart';
import 'package:firebase_flutter_life/Services/audio_service.dart';
import 'package:firebase_flutter_life/UI/screens/home_screen.dart';
import 'package:firebase_flutter_life/UI/screens/user_profile_screens/user_profile_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Post extends StatefulWidget {
  final String title;
  final String topic;
  final String postID;
  final String userID;
  final String recordingURL;
  final String username;
  final String userImage;
  final dynamic likes;

  Post({
    @required this.title,
    @required this.topic,
    @required this.postID,
    @required this.userID,
    @required this.recordingURL,
    @required this.username,
    @required this.userImage,
    this.likes,
  });

  factory Post.fromDocument(DocumentSnapshot doc) {
    return Post(
      title: doc["title"],
      topic: doc["topic"],
      postID: doc["postID"],
      userID: doc["userID"],
      recordingURL: doc["recordingURL"],
      username: doc["username"],
      userImage: doc["userImage"],
      likes: doc['likes'],
    );
  }
  @override
  _PostState createState() => _PostState(
        title: this.title,
        topic: this.topic,
        postID: this.postID,
        userID: this.userID,
        recordingURL: this.recordingURL,
        username: this.username,
        userImage: this.userImage,
        likes: this.likes,
      );
}

class _PostState extends State<Post> {
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
  Map likes;

  _PostState({
    this.title,
    this.topic,
    this.postID,
    this.userID,
    this.recordingURL,
    this.username,
    this.userImage,
    this.likeCount,
    this.likes,
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

  handleLikePost() async {
    var currentUser = await FirebaseAuth.instance.currentUser();
    String currentUserId = currentUser.uid;
    bool _isLiked = likes[currentUserId] == true;

    if (_isLiked) {
      PostRepository()
          .postsRef
          .document(postID)
          .updateData({'likes.$currentUserId': false});
      setState(() {
        likeCount -= 1;
        isLiked = false;
        likes[currentUserId] = false;
      });
    } else if (!_isLiked) {
      PostRepository()
          .postsRef
          .document(postID)
          .updateData({'likes.$currentUserId': true});
      addToFavorites();
      setState(() {
        likeCount += 1;
        isLiked = true;
        likes[currentUserId] = true;
        showHeart = true;
      });
      Timer(Duration(milliseconds: 500), () {
        setState(() {
          showHeart = false;
        });
      });
    }
  }

  addToFavorites() async {
    var currentUser = await FirebaseAuth.instance.currentUser();
    String currentUserId = currentUser.uid;
    PostRepository()
        .favoritesRef
        .document(currentUserId)
        .collection("userFavorites")
        .document(postID)
        .setData({
      "title": title,
      "topic": topic,
      "postID": postID,
      "userID": userID,
      "recordingURL": recordingURL,
      "username": username,
      "userImage": userImage,
      "likes": {},
    });
  }

  showProfile(context, profileID) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserProfileScreen(profileID: profileID),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    isLiked = (likes[user.userID] == true);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          AudioService().play(recordingURL);
        },
        child: Card(
          margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
          child: ListTile(
            leading: buildPostHeader(),
            title: Row(
              children: <Widget>[
                Text(
                  topic,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 13),
                )
              ],
            ),
            subtitle: GestureDetector(
              onTap: () {
                user.userID != userID
                    ? showProfile(context, userID)
                    : print("this is your profile");
              },
              child: Text(
                username,
                style: TextStyle(fontWeight: FontWeight.w200, fontSize: 14),
              ),
            ),
            trailing: GestureDetector(
              onTap: handleLikePost,
              child: Icon(
                isLiked ? Icons.favorite : Icons.favorite_border,
                size: 28.0,
                color: Colors.lightGreen[100],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
