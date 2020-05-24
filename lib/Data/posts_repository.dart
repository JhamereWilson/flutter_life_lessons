import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_flutter_life/Models/post_model.dart';

class PostRepository {
  
  final CollectionReference publicPostsRef = Firestore.instance.collection("publicPosts");

  final CollectionReference postsRef = Firestore.instance.collection("posts");
  
  




  // //
  //  List<Post>_publicPostsFromSnapshot(QuerySnapshot snapshot) {
  //    return snapshot.documents.map((doc){
  //      return Post(
  //        title: doc.data["title"],
  //        topic: doc.data["topic"],
  //        userID: doc.data["userID"],
  //      );
  //    }).toList();
  //  }

   

    // Stream<List<Post>> get posts {
    //   return publicPostsRef.snapshots().map(_publicPostsFromSnapshot);
    // }

  //  Future<Post> getPostsByTopic(String topic) async {
  //    var snapshot = await publicPostsRef.where("topic", isEqualTo: topic).getDocuments();
  //    return Post.fromDocument(snapshot);
  //  }

  //Cloud Firestore Fetch 
  Stream<List<Post>> streamPostByTopic(String topic){
     var ref = publicPostsRef.where("topic", isEqualTo: topic);
     return ref.snapshots().map((list) => 
     list.documents.map((doc) => Post.fromDocument(doc)).toList()
     ); 
   }

     Stream<List<Post>> streamPostByUser(String userID){
     var ref = postsRef.where("userID", isEqualTo: userID);
     return ref.snapshots().map((list) => 
     list.documents.map((doc) => Post.fromDocument(doc)).toList()
     ); 
   }

   //Realtime Database Fetch
  //    Stream<List<Post>> streamLessonsByTopic(String topic){
  //    var postsRefByTopic = FirebaseDatabase.instance.reference().child("posts").;
  //    return postsRef.
     
     
  //    snapshot().map((list) => 
  //    list.documents.map((doc) => Post.fromSnapshot(doc)).toList()
  //    ); 
  //  }


  

  

  
}