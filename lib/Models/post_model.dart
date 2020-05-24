import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_flutter_life/Data/user_repository.dart';
import 'package:firebase_flutter_life/Models/models.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Post extends StatefulWidget {
  final String title;
  final String topic;
  final String postID;
  final String userID;
  final String recordingURL;
  final String username;
  final String userImage;
  // bool isFavorite;

  Post({
    @required this.title,
    @required this.topic,
    @required this.postID,
    @required this.userID,
    @required this.recordingURL,
    @required this.username,
    @required this.userImage,
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

  _PostState({
    this.title,
    this.topic,
    this.postID,
    this.userID,
    this.recordingURL,
    this.username,
    this.userImage,
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

  // handleDeletePost(BuildContext parentContext) {
  //   return showDialog(
  //       context: parentContext,
  //       builder: (context) {
  //         return SimpleDialog(
  //           title: Text("Remove this post?"),
  //           children: <Widget>[
  //             SimpleDialogOption(
  //                 onPressed: () {
  //                   Navigator.pop(context);
  //                   deletePost();
  //                 },
  //                 child: Text(
  //                   'Delete',
  //                   style: TextStyle(color: Colors.red),
  //                 )),
  //             SimpleDialogOption(
  //                 onPressed: () => Navigator.pop(context),
  //                 child: Text('Cancel')),
  //           ],
  //         );
  //       });
  // }

  // Note: To delete post, ownerId and currentUserId must be equal, so they can be used interchangeably
  // deletePost() async {
  //   // delete post itself
  //   postsRef
  //       .document(ownerId)
  //       .collection('userPosts')
  //       .document(postId)
  //       .get()
  //       .then((doc) {
  //     if (doc.exists) {
  //       doc.reference.delete();
  //     }
  //   });
  //   // delete uploaded image for thep ost
  //   storageRef.child("post_$postId.jpg").delete();
  //   // then delete all activity feed notifications
  //   QuerySnapshot activityFeedSnapshot = await activityFeedRef
  //       .document(ownerId)
  //       .collection("feedItems")
  //       .where('postId', isEqualTo: postId)
  //       .getDocuments();
  //   activityFeedSnapshot.documents.forEach((doc) {
  //     if (doc.exists) {
  //       doc.reference.delete();
  //     }
  //   });
  //   // then delete all comments
  //   QuerySnapshot commentsSnapshot = await commentsRef
  //       .document(postId)
  //       .collection('comments')
  //       .getDocuments();
  //   commentsSnapshot.documents.forEach((doc) {
  //     if (doc.exists) {
  //       doc.reference.delete();
  //     }
  //   });
  // }

  // handleLikePost() {
  //   bool _isLiked = likes[currentUserId] == true;

  //   if (_isLiked) {
  //     postsRef
  //         .document(ownerId)
  //         .collection('userPosts')
  //         .document(postId)
  //         .updateData({'likes.$currentUserId': false});
  //     removeLikeFromActivityFeed();
  //     setState(() {
  //       likeCount -= 1;
  //       isLiked = false;
  //       likes[currentUserId] = false;
  //     });
  //   } else if (!_isLiked) {
  //     postsRef
  //         .document(ownerId)
  //         .collection('userPosts')
  //         .document(postId)
  //         .updateData({'likes.$currentUserId': true});
  //     addLikeToActivityFeed();
  //     setState(() {
  //       likeCount += 1;
  //       isLiked = true;
  //       likes[currentUserId] = true;
  //       showHeart = true;
  //     });
  //     Timer(Duration(milliseconds: 500), () {
  //       setState(() {
  //         showHeart = false;
  //       });
  //     });
  //   }
  // }

  // addLikeToActivityFeed() {
  //   // add a notification to the postOwner's activity feed only if comment made by OTHER user (to avoid getting notification for our own like)
  //   bool isNotPostOwner = currentUserId != ownerId;
  //   if (isNotPostOwner) {
  //     activityFeedRef
  //         .document(ownerId)
  //         .collection("feedItems")
  //         .document(postId)
  //         .setData({
  //       "type": "like",
  //       "username": currentUser.username,
  //       "userId": currentUser.id,
  //       "userProfileImg": currentUser.photoUrl,
  //       "postId": postId,
  //       "mediaUrl": mediaUrl,
  //       "timestamp": timestamp,
  //     });
  //   }
  // }

  // removeLikeFromActivityFeed() {
  //   bool isNotPostOwner = currentUserId != ownerId;
  //   if (isNotPostOwner) {
  //     activityFeedRef
  //         .document(ownerId)
  //         .collection("feedItems")
  //         .document(postId)
  //         .get()
  //         .then((doc) {
  //       if (doc.exists) {
  //         doc.reference.delete();
  //       }
  //     });
  //   }
  // }

  // buildPostImage() {
  //   return GestureDetector(
  //     onDoubleTap: handleLikePost,
  //     child: Stack(
  //       alignment: Alignment.center,
  //       children: <Widget>[
  //         cachedNetworkImage(mediaUrl),
  //         showHeart
  //             ? Animator(
  //                 duration: Duration(milliseconds: 300),
  //                 tween: Tween(begin: 0.8, end: 1.4),
  //                 curve: Curves.elasticOut,
  //                 cycles: 0,
  //                 builder: (anim) => Transform.scale(
  //                   scale: anim.value,
  //                   child: Icon(
  //                     Icons.favorite,
  //                     size: 80.0,
  //                     color: Colors.red,
  //                   ),
  //                 ),
  //               )
  //             : Text(""),
  //       ],
  //     ),
  //   );
  // }

  // buildPostFooter() {
  //   return Column(
  //     children: <Widget>[
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         children: <Widget>[
  //           Padding(padding: EdgeInsets.only(top: 40.0, left: 20.0)),
  //           GestureDetector(
  //             onTap: handleLikePost,
  //             child: Icon(
  //               isLiked ? Icons.favorite : Icons.favorite_border,
  //               size: 28.0,
  //               color: Colors.pink,
  //             ),
  //           ),
  //           Padding(padding: EdgeInsets.only(right: 20.0)),
  //           GestureDetector(
  //             onTap: () => showComments(
  //               context,
  //               postId: postId,
  //               ownerId: ownerId,
  //               mediaUrl: mediaUrl,
  //             ),
  //             child: Icon(
  //               Icons.chat,
  //               size: 28.0,
  //               color: Colors.blue[900],
  //             ),
  //           ),
  //         ],
  //       ),
  //       Row(
  //         children: <Widget>[
  //           Container(
  //             margin: EdgeInsets.only(left: 20.0),
  //             child: Text(
  //               "$likeCount likes",
  //               style: TextStyle(
  //                 color: Colors.black,
  //                 fontWeight: FontWeight.bold,
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //       Row(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: <Widget>[
  //           Container(
  //             margin: EdgeInsets.only(left: 20.0),
  //             child: Text(
  //               "$username ",
  //               style: TextStyle(
  //                 color: Colors.black,
  //                 fontWeight: FontWeight.bold,
  //               ),
  //             ),
  //           ),
  //           Expanded(child: Text(description))
  //         ],
  //       ),
  //     ],
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    // isLiked = (likes[currentUserId] == true);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          leading: buildPostHeader(),
          title: Text(title),
          subtitle: Text(username),
           trailing: IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: () {},
              ),
        ),
      ),
    );
  }
}

// showComments(BuildContext context,
//     {String postId, String ownerId, String mediaUrl}) {
//   Navigator.push(context, MaterialPageRoute(builder: (context) {
//     return Comments(
//       postId: postId,
//       postOwnerId: ownerId,
//       postMediaUrl: mediaUrl,
//     );
//   }));
// }
