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

}
