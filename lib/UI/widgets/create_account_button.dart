// import 'package:firebase_flutter_life/Repositories/user_repository.dart';
// import 'package:firebase_flutter_life/UI/screens/register_screen.dart';
// import 'package:flutter/material.dart';


// class CreateAccountButton extends StatelessWidget {
//   final UserRepository _userRepository;

//   CreateAccountButton({Key key, @required UserRepository userRepository})
//       : assert(userRepository != null),
//         _userRepository = userRepository,
//         super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return FlatButton(
//       child: Text(
//         'Forgot Password?', style: TextStyle(color: Color(0xFF95B7C1)),
//       ),
//       onPressed: () {
//         Navigator.of(context).push(
//           MaterialPageRoute(builder: (context) {
//             return RegisterScreen(userRepository: _userRepository);
//           }),
//         );
//       },
//     );
//   }
// }
