// import 'package:firebase_flutter_life/Repositories/user_repository.dart';
// import 'package:firebase_flutter_life/UI/screens/login_screen.dart';
// import 'package:firebase_flutter_life/UI/screens/register_screen.dart';
// import 'package:flutter/material.dart';

// class AuthenticationScreen extends StatelessWidget {
//   final UserRepository _userRepository;

//   AuthenticationScreen({Key key, @required UserRepository userRepository})
//       : assert(userRepository != null),
//         _userRepository = userRepository,
//         super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         appBar: AppBar(
//           elevation: 0.0,
//           centerTitle: true,
//           title: Text("Life Lessons"),
//           flexibleSpace: Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.bottomRight,
//                 end: Alignment.topLeft,
//                 colors: <Color>[
//                   Colors.lightGreen[200],
//                   Colors.lightBlue[600],
//                 ],
//               ),
//             ),
//           ),
//           bottom: TabBar(
//             indicatorSize: TabBarIndicatorSize.label,
//             unselectedLabelColor: Colors.white,
//             labelColor: Colors.grey[600],
//             indicator: BoxDecoration(
//               borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(10), topRight: Radius.circular(10)),
//               color: Colors.white,
//             ),
//             tabs: <Widget>[
//               Tab(
//                 child: Align(
//                   alignment: Alignment.center,
//                   child: Text("Sign Up", style: TextStyle(fontWeight: FontWeight.w600),),
//                 ),
//               ),
//                Tab(
//                 child: Align(
//                   alignment: Alignment.center,
//                   child: Text("Login", style: TextStyle(fontWeight: FontWeight.w600),),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         body: TabBarView(
//           children: <Widget>[
//             RegisterScreen(userRepository: _userRepository),
//             LoginScreen(userRepository: _userRepository)
//           ],
//         ),
//       ),
//     );
//   }
// }
