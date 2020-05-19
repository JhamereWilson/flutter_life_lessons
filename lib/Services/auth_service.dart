import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutter_life/Models/models.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference usersRef = Firestore.instance.collection('users');


  // create user object based on firebase user
  User _userFromFirebaseUser(FirebaseUser user) {
   if (user != null) {
     return User(userID: user.uid);
   }
   print("ERROR: User not found");
   return null;
  }

  //auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }
  
  // sign in anonymously

  // Future signInAnon() async {
  //   try {
  //     AuthResult result await _auth.signInAnonymously();
  //     FirebaseUser user = result.user;
  //     return user;
  //   } catch(e) {
      
  //   }
  // }


  // sign in with email & password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user= result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register with email & password
  Future registerWithEmailAndPassword(String username, String email, String password) async {
    try {
      final AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      await registerUserInFirestore(user.uid, username, email);
      return _userFromFirebaseUser(user);
    } catch(e) {
       print(e.toString());
        return null;
    }
  }

  //sign out 

  Future signOut() async {
    try {
      return await _auth.signOut();
    }
    catch(e) {
      print(e.toString());
    }
  }

    Future registerUserInFirestore(String userID, String username,
       String email ) async {
     final newUserRef = usersRef.document(userID);

     newUserRef.setData({
       "username": username,
       "email": email,
       "userID": userID,
     });
   }
}