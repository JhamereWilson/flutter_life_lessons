import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Post {
  final String title;
  final String topic;
  final String userID;
  final String imageUrl;
  bool isFavorite;

  Post({
    @required this.imageUrl,
    @required this.title,
    @required this.topic,
    @required this.userID,
  });

  factory Post.fromFirestore(DocumentSnapshot doc) {
    return Post(
      title: doc.data["title"],
      topic: doc.data["topic"],
      userID: doc.data["userID"], 
      imageUrl: doc.data["imageUrl"],
    );
  }
}
