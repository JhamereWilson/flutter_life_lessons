import 'package:firebase_flutter_life/Services/auth_service.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = "";
  String password = "";
  String error = "";

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus(); // gets rid of keyboard on submit
    if (isValid) {
      _formKey.currentState.save();
    }
    dynamic result = _auth.signInWithEmailAndPassword(email, password);
    if (result == null) {
      setState(() => error = "Invalid email or password.");
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(error),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      Navigator.pushReplacementNamed(context, "/root");
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.email),
                      labelText: 'Your Email Address',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    autovalidate: true,
                    autocorrect: false,
                    onChanged: (val) {
                      setState(() => email = val);
                    }),
                TextFormField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.lock),
                    labelText: 'Password',
                  ),
                  obscureText: true,
                  autovalidate: true,
                  autocorrect: false,
                  onChanged: (val) {
                    setState(() => password = val);
                  },
                  validator: (val) => val.isEmpty || val.length < 6
                      ? "Password must be 6 or more characters."
                      : null,
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 250,
                  height: 50,
                  child: RaisedButton(
                    onPressed: () => _trySubmit(),
                    child: Text("Login"),
                  ),
                ),
                Text(error,
                    style: TextStyle(color: Colors.red, fontSize: 14.0)),
                FlatButton(
                  onPressed: () {},
                  child: Text("Forgot Password?"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
