
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'login_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
          style: TextStyle(color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.w400),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // Container(
            //     width: double.infinity,
            //     height: 30,
            //     decoration: BoxDecoration(
            //       gradient: LinearGradient(
            //         begin: Alignment.bottomRight,
            //         end: Alignment.topLeft,
            //         colors: <Color>[
            //           Colors.lightGreen[200],
            //           Colors.lightBlue[600],
            //         ],
            //       ),
            //     ),
            //     child: Center(
            //       child: Text("Account Settings",
            //           textAlign: TextAlign.center,
            //           style: TextStyle(
            //               fontWeight: FontWeight.w400,
            //               fontSize: 16.0,
            //               color: Colors.white)),
            //     )),
            // Divider(height: 0),
            // _createTile(context, "Name", Icons.arrow_forward_ios, () {}),
            // Divider(height: 0),
            // _createTile(context, "Username", Icons.arrow_forward_ios, () {}),
            // Divider(height: 0),
            // _createTile(context, "Email", Icons.arrow_forward_ios, () {}),
            // Divider(height: 0),
            // _createTile(context, "Location", Icons.arrow_forward_ios, () {}),
            // Divider(height: 0),
            // _createTile(context, "Password", Icons.arrow_forward_ios, () {}),
            // Divider(height: 0),
            // Container(
            //     width: double.infinity,
            //     height: 30,
            //     decoration: BoxDecoration(
            //       gradient: LinearGradient(
            //         begin: Alignment.bottomRight,
            //         end: Alignment.topLeft,
            //         colors: <Color>[
            //           Colors.lightGreen[200],
            //           Colors.lightBlue[600],
            //         ],
            //       ),
            //     ),
            //     child: Center(
            //       child: Text("Notification Settings",
            //           textAlign: TextAlign.center,
            //           style: TextStyle(
            //               fontWeight: FontWeight.w400,
            //               fontSize: 16.0,
            //               color: Colors.white)),
            //     )),
            // _createTile(context, "Turn Off All Notifications",
            //     Icons.arrow_forward_ios, () {}),
            // Divider(height: 0),
            // _createTile(context, "Messages", Icons.arrow_forward_ios, () {}),
            // Divider(height: 0),
            // _createTile(
            //     context, "Posts and Favorites", Icons.arrow_forward_ios, () {}),
            // Divider(height: 0),
            // _createTile(context, "Follower and Following",
            //     Icons.arrow_forward_ios, () {}),
            // SizedBox(height: 10),
            Container(
                width: double.infinity,
                height: 30,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                    colors: <Color>[
                      Colors.lightGreen[200],
                      Colors.lightBlue[600],
                    ],
                  ),
                ),
                child: Center(
                  child: Text("Feedback",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16.0,
                          color: Colors.white)),
                )),
            _createTile(
                context, "Report a Bug", Icons.arrow_forward_ios, () {}),
            Divider(height: 0),
            _createTile(context, "Suggestions", Icons.arrow_forward_ios, () {}),
            // Container(
            //     width: double.infinity,
            //     height: 30,
            //     decoration: BoxDecoration(
            //       gradient: LinearGradient(
            //         begin: Alignment.bottomRight,
            //         end: Alignment.topLeft,
            //         colors: <Color>[
            //           Colors.lightGreen[200],
            //           Colors.lightBlue[600],
            //         ],
            //       ),
            //     ),
            //     child: Center(
            //       child: Text("Legal",
            //           textAlign: TextAlign.center,
            //           style: TextStyle(
            //               fontWeight: FontWeight.w400,
            //               fontSize: 16.0,
            //               color: Colors.white)),
            //     )),
            // _createTile(
            //     context, "Privacy Policy", Icons.arrow_forward_ios, () {}),
            // Divider(height: 0),
            // _createTile(
            //     context, "Terms of Service", Icons.arrow_forward_ios, () {}),
            // Divider(),
            // SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 40,
                          child: RaisedButton(
                
                color: Colors.red,
                child: Text("Log Out", style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w400),),
                shape: RoundedRectangleBorder(
                  //borderRadius: BorderRadius.circular(20.0),
                ), 
                onPressed: () {
               FirebaseAuth.instance.signOut();
               Navigator.pushNamed(context, LoginScreen.routeName);
               
                  print("user logged out");
                },
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  ListTile _createTile(
      BuildContext context, String name, IconData icon, Function action) {
    return ListTile(
      trailing: Icon(
        icon,
        size: 13.0,
        color: Colors.black26,
      ),
      title: Text(name, style: TextStyle(fontSize: 14.0),),
      onTap: () {
        Navigator.pop(context);
        action();
      },
    );
  }
}

// Material(
//           child: Column(
//         children: <Widget>[
//           UserAccountsDrawerHeader(
//             accountEmail: Text("User Email Address"),
//             accountName: Text("Username"),
//             currentAccountPicture: GestureDetector(
//               onTap: () {},
//               child: CircleAvatar(
//                  radius: 50,
//                   backgroundImage: AssetImage('assets/images/womanAvatar.jpg'),
//                   backgroundColor: Colors.transparent
//               ),
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.only(top: 20),
//           ),
//           ListTile(
//             leading: Icon(FontAwesomeIcons.inbox),
//             title: Text('Inbox'),
//           ),
//           ListTile(
//             leading: Icon(FontAwesomeIcons.edit),
//             title: Text('Edit Profile'),
//           ),
//           ListTile(
//             leading: Icon(FontAwesomeIcons.solidThumbsUp),
//             title: Text('Favorites'),
//           ),
//           ListTile(
//             leading: Icon(Icons.people),
//             title: Text('Discover Friends'),
//           ),
//           ListTile(
//             leading: Icon(FontAwesomeIcons.cogs),
//             title: Text('Settings'),
//           ),
//           Divider(),
//           Expanded(
//             child: Align(
//               alignment: FractionalOffset.bottomCenter,
//               child: ListTile(
//                 leading: Icon(FontAwesomeIcons.doorOpen),
//                 title: Text(
//                   'Log Out',
//                   style: TextStyle(color: Colors.red),
//                 ),
//                 onTap: () {
//                   BlocProvider.of<AuthenticationBloc>(context).add(
//                     LoggedOut(),
//                   );
//                 },
//               ),
//             ),
//           )
//         ],
//       ),
//     );
