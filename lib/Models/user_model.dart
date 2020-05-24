import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String userID;
  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final String profileImageUrl;
  final String bio;
  final String location;

  User({
    this.userID,
    this.username,
    this.firstName,
    this.lastName,
    this.email,
    this.profileImageUrl,
    this.bio,
    this.location,
  });

    factory User.fromDocument(DocumentSnapshot doc) {
    return User(
      userID: doc['userID'],
      email: doc['email'],
      username: doc['username'],
      profileImageUrl: doc['profileImageUrl'],
      bio: doc['bio'],
      location: doc['location'],
    );
  }

}
