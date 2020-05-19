import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutter_life/Models/models.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'UI/screens/profile_screens/profile_screen.dart';
import 'UI/screens/record_screens/record_begin_screen.dart';
import 'UI/screens/record_screens/record_screen.dart';
import 'UI/screens/screens.dart';
import 'UI/screens/topic_screens/topics_screen.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
          stream: FirebaseAuth.instance.onAuthStateChanged,
          builder: (ctx, userSnapshot) {
            if (userSnapshot.hasData) {
              return HomeScreen();
            }
            return RegisterScreen();
          }),
      routes: {
        '/topic-screen': (context) => TopicsScreen(),
        '/record-screen': (context) => RecordBeginScreen(),
        '/record-action': (context) => RecordScreen(),
        '/profile-screen': (context) => ProfileScreen(),
        '/login-screen': (context) => LoginScreen(),
        '/register-screen': (context) => RegisterScreen(),
      },
    );
  }
}
