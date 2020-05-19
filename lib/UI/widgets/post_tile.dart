import 'package:firebase_flutter_life/Data/user_repository.dart';
import 'package:firebase_flutter_life/Models/models.dart';
import 'package:firebase_flutter_life/Models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostTile extends StatelessWidget {
  final Post post;

  const PostTile({Key key, this.post}) : super(key: key);

// void _showMoreOptions(){
//   showModalBottomSheet(context: context, builder: (context){
//     Container(
//       padding: EdgeInsets.all(8.0),
//       child: Column(
//         children: <Widget>[
//           ListTile(
//             leading:Icon(Icons.favorite) ,
//             title: Text("Add To Favorites"),
//           ),
//            ListTile(
//             leading:Icon(Icons.person) ,
//             title: Text("Go To User Profile"),
//           ),
//         ],
//       ),
//     );
//   });
//}
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: UserRepository().usersRef.document(post.userID).get(),
      builder: (context, snapshot) {
        return Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: Card(
            margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
            child: ListTile(
              leading: CircleAvatar(radius: 25.0, backgroundColor: Colors.red),
              title: Text(post.title),
              subtitle: Text(snapshot.data['username']),
              trailing: IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: () {},
              ),
            ),
          ),
        );
      },
    );
  }
}
