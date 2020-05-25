import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutter_life/Data/posts_repository.dart';
import 'package:firebase_flutter_life/Models/models.dart';
import 'package:firebase_flutter_life/Models/post_model.dart';
import 'package:flutter/material.dart';

class UserFavoriteBookScreen extends StatefulWidget {
  final String profileID;

  const UserFavoriteBookScreen({Key key, this.profileID}) : super(key: key);

  @override
  _UserFavoriteBookScreenState createState() => _UserFavoriteBookScreenState();
}

class _UserFavoriteBookScreenState extends State<UserFavoriteBookScreen> {
  List<Post> posts;

  @override
  void initState() {
    super.initState();
    getTimeline();
  }

  getTimeline() async {
    QuerySnapshot snapshot = await PostRepository()
        .favoritesRef
        .document(widget.profileID)
        .collection("userFavorites")
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
      return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 70),
            Icon(
              Icons.filter_none,
              color: Colors.black26,
            ),
            SizedBox(height: 20),
            Text(
              "Uh oh, this user doesn't have any favorited lessons!",
              style: TextStyle(color: Colors.black26, fontSize: 16.0),
            ),
            SizedBox(height: 20),
          ],
        ),
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
