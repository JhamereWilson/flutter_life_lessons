import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_flutter_life/Data/posts_repository.dart';
import 'package:firebase_flutter_life/Models/post_model.dart';
import 'package:flutter/material.dart';

class TopicSelectedScreen extends StatefulWidget {
  final String topic;

  const TopicSelectedScreen({Key key, this.topic}) : super(key: key);

  @override
  _TopicSelectedScreenState createState() => _TopicSelectedScreenState();
}

class _TopicSelectedScreenState extends State<TopicSelectedScreen> {
  List<Post> posts;

  @override
  void initState() {
    super.initState();
    getTimeline();
  }

  getTimeline() async {
    QuerySnapshot snapshot = await PostRepository()
        .postsRef
        .where("topic", isEqualTo: widget.topic)
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
      return Center(
        child: Text("No Lessons Recorded Yet. Record one today!"),
      );
    } else {
      return ListView(children: posts);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.topic)),
      body: RefreshIndicator(
        onRefresh: () => getTimeline(),
        child: buildTimeline(),
      ),
    );
  }
}
