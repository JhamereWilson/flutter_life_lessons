import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutter_life/Data/posts_repository.dart';
import 'package:firebase_flutter_life/Models/models.dart';
import 'package:firebase_flutter_life/Models/post_model.dart';
import 'package:firebase_flutter_life/Models/private_post_model.dart';
import 'package:firebase_flutter_life/UI/screens/screens.dart';
import 'package:flutter/material.dart';

class UserPrivateBookScreen extends StatefulWidget {
 final String profileID;

  const UserPrivateBookScreen({Key key, this.profileID}) : super(key: key);

  

  @override
  _UserPrivateBookScreenState createState() => _UserPrivateBookScreenState();
}

class _UserPrivateBookScreenState extends State<UserPrivateBookScreen> {

  final followersRef = Firestore.instance.collection('followers');
  final followingRef = Firestore.instance.collection('following');

  bool accessGranted = false;

   List<PrivatePost> posts;

     @override
  void initState() {
    super.initState();
    getTimeline();
  }


  checkIfAccessGranted() async {
    var currentUser = await FirebaseAuth.instance.currentUser();
    String currentUserId = currentUser.uid;
    DocumentSnapshot doc = await followingRef
        .document(currentUserId)
        .collection('userFollowers')
        .document(widget.profileID)
        .get();
    setState(() {
      accessGranted = doc.exists;
    });
  }

    getTimeline() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    QuerySnapshot snapshot = await PostRepository()
        .privatePostsRef
        .document(user.uid)
        .collection("privateUserPosts")
        .getDocuments();
    List<PrivatePost> posts =
        snapshot.documents.map((doc) => PrivatePost.fromDocument(doc)).toList();
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
          Icon(Icons.filter_none, color: Colors.black26,),
              SizedBox(height: 20),
          Text("It looks like you haven't started your private book yet.", style: TextStyle(color: Colors.black26, fontSize: 16.0),),
              SizedBox(height: 20),
          Text("To start a private book, record a lesson and select the option 'add to private book' ", style: TextStyle(color: Colors.black26, fontSize: 16.0), textAlign: TextAlign.center,),
              SizedBox(height: 30),
          SizedBox(
            height: 50,
            width: 250,
                    child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
              color: Colors.indigo[300],
              onPressed: (){},
              child: Text("Record your first private lesson!", style: TextStyle(color: Colors.white),textAlign: TextAlign.center,),
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