import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_flutter_life/Models/models.dart';

import 'package:firebase_flutter_life/Services/firestore_path.dart';
import 'package:meta/meta.dart';

 class UserRepository {
   final String uid;
   UserRepository({this.uid});

   //collection reference
   final CollectionReference usersRef = Firestore.instance.collection('users');
   

   Future updateUserInfo( String profileImageUrl, String location, String bio ) async {
     final newUserRef = usersRef.document(uid);
     newUserRef.setData({
       "userID": uid,
       "profileImageURL": profileImageUrl,
       "location": location,
       "bio": bio,
     });
   }


   //userData from snapshot 
     User _userDataFromSnapshot(DocumentSnapshot doc) {
    return User(
      userID: doc['userID'],
      username: doc['username'],
      firstName: doc['firstName'],
      lastName: doc['lastName'],
      email: doc['email'],
      profileImageUrl: doc['profileImageUrl'],
      bio: doc['bio'],
      location: doc['location'],
    );
  }

   // get userData doc stream 
   Stream<User> get userData {
     return usersRef.document(uid).snapshots().map(_userDataFromSnapshot);
   }

  





   Future<void>setUserProfilePhotoReference({
     @required String uid,
     @required ProfilePhotoReference profilePhotoReference,
   }) async {
     final path = FirestorePath.profilePhoto(uid);
     final reference = Firestore.instance.document(path);
     await reference.setData(profilePhotoReference.toMap());
   }


  // Reads the current avatar download url
  Stream< ProfilePhotoReference> profilePhotoReferenceStream() {
    final path = FirestorePath.profilePhoto(uid);
    final reference = Firestore.instance.document(path);
    final snapshots = reference.snapshots();
    return snapshots.map((snapshot) =>  ProfilePhotoReference.fromMap(snapshot.data));
  }
 }