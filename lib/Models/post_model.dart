import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Post {
  final String title;
  final String topic;
  final String userID;
  final String recordingURL;
  final String username;
  final String userImage;
  bool isFavorite;

  Post({
    @required this.title,
    @required this.topic,
    @required this.userID,
    @required this.recordingURL,
    @required this.username,
    @required this.userImage,
  });

  factory Post.fromFirestore(DocumentSnapshot doc) {
    return Post(
      title: doc.data["title"],
      topic: doc.data["topic"],
      userID: doc.data["userID"], 
      recordingURL: doc.data["recordingURL"],
      username: doc.data["username"],
      userImage: doc.data["userImage"],
    );
  }
}
