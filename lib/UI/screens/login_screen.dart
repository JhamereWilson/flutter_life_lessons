import 'package:firebase_flutter_life/UI/widgets/widgets.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = "/login-screen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {},
           
          )
        ],
      ),
      body: SingleChildScrollView(
              child: Column(
          children: <Widget>[
            Text("life lessons", style: TextStyle(color: Colors.blue, fontSize: 28.0, fontWeight: FontWeight.w500),),
            LoginForm(),
              Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Don't have an account?"),
                FlatButton(
                  textColor: Colors.blue,
                  onPressed: () {},
                  child: Text("Sign Up"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
