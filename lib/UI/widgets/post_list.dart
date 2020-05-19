
import 'package:firebase_flutter_life/Models/post_model.dart';
import 'package:firebase_flutter_life/UI/widgets/post_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostList extends StatelessWidget {
  


  @override
  Widget build(BuildContext context) {

    var posts = Provider.of<List<Post>>(context);
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return PostTile(post: posts
        [index]);
      },
    );
  }
}