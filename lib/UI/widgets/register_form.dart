import 'package:firebase_flutter_life/Services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegisterForm extends StatefulWidget {
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String username = "";
  String email = "";
  String password = "";
  String error = "";

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus(); // gets rid of keyboard on submit
    if (isValid) {
      _formKey.currentState.save();
    }
    try {
      _auth.registerWithEmailAndPassword(username, email, password);
    } on PlatformException catch (err) {
      // Platform Exception throws a Firebase Error =>  "platform"

      var message = "An error occured, please check credentials.";
      if (err.message != null) {
        message = err.message;
      }
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
        ),
      );
    } catch (err) {
      print(err);
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
                  validator: (val) => val.isEmpty || val.length < 6
                      ? "Username must be 6 or more characters."
                      : null,
                  decoration: InputDecoration(
                    icon: Icon(Icons.person),
                    labelText: 'Username',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (val) {
                    username = val;
                  },
                ),
                TextFormField(
                  validator: (val) => val.isEmpty || !val.contains('@')
                      ? "Please enter a valid email."
                      : null,
                  decoration: InputDecoration(
                    icon: Icon(Icons.email),
                    labelText: 'Your Email Address',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (val) {
                    email = val;
                  },
                ),
                TextFormField(
                  validator: (val) => val.isEmpty || val.length < 6
                      ? "Password must be 6 or more characters."
                      : null,
                  decoration: InputDecoration(
                    icon: Icon(Icons.lock),
                    labelText: 'Password',
                  ),
                  obscureText: true,
                  onSaved: (val) {
                    password = val;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 250,
                  height: 50,
                  child: RaisedButton(
                    onPressed: () async {
                      // if (_formKey.currentState.validate()) {
                      _trySubmit();
                    },
                    child: Text("Register"),
                  ),
                ),
                Text(error,
                    style: TextStyle(color: Colors.red, fontSize: 14.0)),
                FlatButton(
                  onPressed: () {},
                  child: Text("Already Have an Account?"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
