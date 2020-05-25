import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutter_life/Data/posts_repository.dart';
import 'package:firebase_flutter_life/Models/models.dart';
import 'package:firebase_flutter_life/Models/post_model.dart';
import 'package:flutter/material.dart';

class MyFavoriteBookScreen extends StatefulWidget {
  final User currentUser;

  const MyFavoriteBookScreen({Key key, this.currentUser}) : super(key: key);

  @override
  _MyFavoriteBookScreenState createState() => _MyFavoriteBookScreenState();
}

class _MyFavoriteBookScreenState extends State<MyFavoriteBookScreen> {
  List<Post> posts;

  @override
  void initState() {
    super.initState();
    getTimeline();
  }

  getTimeline() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    QuerySnapshot snapshot = await PostRepository()
        .favoritesRef
        .document(user.uid)
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
              "Uh oh, don't have any favorited lessons!",
              style: TextStyle(color: Colors.black26, fontSize: 16.0),
            ),
            SizedBox(height: 20),
            Text(
              "To favorite a lesson, tap on a lesson you enjoy and select the option 'Add to Favorites'",
              style: TextStyle(color: Colors.black26, fontSize: 16.0),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            SizedBox(
              height: 50,
              width: 250,
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: Colors.indigo[300],
                onPressed: () {
                   Navigator.pushReplacementNamed(context, '/record-screen');
                },
                child: Text(
                  "Listen and favorite a lesson!",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
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
