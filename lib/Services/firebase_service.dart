import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutter_life/Data/posts_repository.dart';
import 'package:firebase_flutter_life/Data/user_repository.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

import 'firestore_path.dart';
import 'package:uuid/uuid.dart';

class FirebaseService {


var postID = Uuid().v4();
final _auth = FirebaseAuth.instance;
final followersRef = Firestore.instance.collection('followers');
final followingRef = Firestore.instance.collection('following');




  /// Generic file upload for any [path] and [contentType]
  Future<String> publicUpload({
    @required File file,
    @required String title,
    @required String topic,
   
  }) async {
    print("recording uploaded");
    final storageReference = FirebaseStorage.instance
        .ref()
        .child("recordings").child(topic)
        .child(postID);
    final uploadTask = storageReference.putFile(
        file, StorageMetadata(contentType: "audio/mp3"));
    final snapshot = await uploadTask.onComplete;

    if (snapshot.error != null) {
      print('upload error code: ${snapshot.error}');
      throw snapshot.error;
    }

    // Url used to download file/image
    final downloadUrl = await snapshot.ref.getDownloadURL();
    print('downloadUrl: $downloadUrl');
    
    final user = await FirebaseAuth.instance.currentUser();
    final userData = await Firestore.instance.collection("users").document(user.uid).get();
    await Firestore.instance
    .collection("posts")
    .document(postID)
    .setData({
      "title" : title,
      "topic" : topic,
      "postID": postID,
      "userID": user.uid,
      "recordingURL": downloadUrl.toString(),
      "username": userData["username"],
      "userImage": userData["userImage"],
      "likes": {},
    });
  }


  /// Generic file upload for any [path] and [contentType]
  Future<String> privateUpload({
    @required File file,
    @required String title,
    @required String topic,
   
  }) async {
    print("recording uploaded");
    final storageReference = FirebaseStorage.instance
        .ref()
        .child("recordings").child(topic)
        .child(postID);
    final uploadTask = storageReference.putFile(
        file, StorageMetadata(contentType: "audio/mp3"));
    final snapshot = await uploadTask.onComplete;

    if (snapshot.error != null) {
      print('upload error code: ${snapshot.error}');
      throw snapshot.error;
    }

    // Url used to download file/image
    final downloadUrl = await snapshot.ref.getDownloadURL();
    print('downloadUrl: $downloadUrl');
    
    final user = await FirebaseAuth.instance.currentUser();
    final userData = await Firestore.instance.collection("users").document(user.uid).get();
    await PostRepository().privatePostsRef.document(user.uid).collection("privateUserPosts")
    .document(postID)
    .setData({
      "title" : title,
      "topic" : topic,
      "postID": postID,
      "userID": user.uid,
      "recordingURL": downloadUrl.toString(),
      "username": userData["username"],
      "userImage": userData["userImage"],
      "likes": {},
    });
  }

  /// Generic file upload for any [path] and [contentType]
  Future<String> photoUpload({
    @required File file,
    @required String path,
    @required String contentType,
  }) async {
    print('uploading to: $path');
    final storageReference =
        FirebaseStorage.instance.ref().child("recordings").child(path);
    final uploadTask = storageReference.putFile(
        file, StorageMetadata(contentType: contentType));
    final snapshot = await uploadTask.onComplete;

    if (snapshot.error != null) {
      print('upload error code: ${snapshot.error}');
      throw snapshot.error;
    }

    // Url used to download file/image
    final downloadUrl = await snapshot.ref.getDownloadURL();
    print('downloadUrl: $downloadUrl');
    return downloadUrl;
  }
  void submitAuthForm(
    String email,
    String password,
    String username,
    File image,
    BuildContext ctx,
   
  ) async {
    AuthResult authResult;

    try {
       {
        authResult = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        final ref = FirebaseStorage.instance
            .ref()
            .child('user_image')
            .child(authResult.user.uid + '.jpg');

        await ref.putFile(image).onComplete;

        final url = await ref.getDownloadURL();

        await Firestore.instance
            .collection('users')
            .document(authResult.user.uid)
            .setData({
          'username': username,
          'email': email,
          'profileImageUrl': url,
          "userID": authResult.user.uid,
        });
      }
    } on PlatformException catch (err) {
      var message = 'An error occurred, pelase check your credentials!';

      if (err.message != null) {
        message = err.message;
      }

      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
    }
  }

  
}
