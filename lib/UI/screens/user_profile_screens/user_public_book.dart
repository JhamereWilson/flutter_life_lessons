import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutter_life/Data/posts_repository.dart';
import 'package:firebase_flutter_life/Data/user_repository.dart';
import 'package:firebase_flutter_life/Models/models.dart';
import 'package:firebase_flutter_life/Models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserPublicBookScreen extends StatefulWidget {
  final String profileID;

  const UserPublicBookScreen({Key key, this.profileID}) : super(key: key);

  @override
  _UserPublicBookScreenState createState() => _UserPublicBookScreenState();
}

class _UserPublicBookScreenState extends State<UserPublicBookScreen> {
  List<Post> posts;

  @override
  void initState() {
    super.initState();
    getTimeline();
  }

  getTimeline() async {
    QuerySnapshot snapshot = await PostRepository()
        .postsRef
        .where("userID", isEqualTo: widget.profileID)
        .getDocuments();
    List<Post> posts =
        snapshot.documents.map((doc) => Post.fromDocument(doc)).toList();
    setState(() {
      this.posts = posts;
    });
  }

  buildTimeline() {
    if (posts == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (posts.isEmpty) {
      return Column(
        children: <Widget>[
          SizedBox(height: 70),
          Icon(
            Icons.filter_none,
            color: Colors.black26,
          ),
          SizedBox(height: 20),
          Text(
            "Uh oh, this user doesn't have any lessons!",
            style: TextStyle(color: Colors.black26, fontSize: 16.0),
          ),
          SizedBox(height: 20),
        ],
      );
    } else {
      return ListView(children: posts);
    }
  }

  @override
  Widget build(BuildContext context) {
    return buildTimeline();
  }
}
