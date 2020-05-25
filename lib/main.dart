import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutter_life/Models/models.dart';
import 'package:firebase_flutter_life/Services/auth_service.dart';
import 'package:firebase_flutter_life/wrapper.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'UI/screens/profile_screens/profile_screen.dart';
import 'UI/screens/record_screens/record_begin_screen.dart';
import 'UI/screens/record_screens/record_screen.dart';
import 'UI/screens/screens.dart';
import 'UI/screens/topic_screens/topics_screen.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
        routes: {
          '/root': (context) => HomeScreen(),
          '/topic-screen': (context) => TopicsScreen(),
          '/record-screen': (context) => RecordBeginScreen(),
          '/record-action': (context) => RecordScreen(),
          '/profile-screen': (context) => ProfileScreen(),
          '/login-screen': (context) => LoginScreen(),
          '/register-screen': (context) => RegisterScreen(),
        },
      ),
    );
  }
}


/* TO DO:
          Skeleton Post Tiles ------ done
          If posts = null .... -------done
          Favorite Posts Lists
          Followers/Following
          Private Posts 
          Private Followers/Following
          Cloud Messaging Through Firebase



*/