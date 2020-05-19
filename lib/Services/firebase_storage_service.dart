import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:meta/meta.dart';

import 'firestore_path.dart';

class FirebaseStorageService{

 FirebaseStorageService({@required this.uid}) : assert(uid != null);
  final String uid;
  
  //upload profile picture from file 
   /// Upload an avatar from file
  Future<String> uploadProfilePhoto({
    @required File file,
  }) async =>
      await photoUpload(
        file: file,
        path: FirestorePath.profilePhoto(uid) + '/profilePhoto.png',
        contentType: 'image/png',
      );



  /// Generic file upload for any [path] and [contentType]
  Future<String> recordingUpload({
    @required File file,
    @required String path,
    @required String contentType, 
  }) async {
    
    print('uploading to: $path');
    final storageReference = FirebaseStorage.instance.ref().child("recordings").child(path);
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

    /// Generic file upload for any [path] and [contentType]
  Future<String> photoUpload({
    @required File file,
    @required String path,
    @required String contentType, 
  }) async {
    
    print('uploading to: $path');
    final storageReference = FirebaseStorage.instance.ref().child("recordings").child(path);
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
}