import 'package:firebase_flutter_life/Data/posts_repository.dart';
import 'package:firebase_flutter_life/Models/models.dart';
import 'package:firebase_flutter_life/Models/post_model.dart';
import 'package:firebase_flutter_life/UI/widgets/post_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectedTopicScreen extends StatelessWidget {
  final User user;
  final String topic;

  SelectedTopicScreen({Key key, this.user, this.topic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(topic)),
      body: PostList(),
    );
  }
}
