import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Models/models.dart';


import 'UI/screens/home_screen.dart';
import 'UI/screens/screens.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    //return either Home Screen or Authenticate widget
    if (user != null) {
      return HomeScreen();
    }
    return WalkthroughScreen();
  }
}
