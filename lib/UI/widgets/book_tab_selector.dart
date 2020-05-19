// import 'package:firebase_flutter_life/Models/app_tab.dart';
// import 'package:firebase_flutter_life/Models/models.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';


// class BookTabSelector extends StatelessWidget {
//   final BookTab activeTab;
//   final Function(BookTab) onTabSelected;
//   final TabController tabController = TabController(length: 3, vsync: this);

//   BookTabSelector({
//     Key key,
//     @required this.activeTab,
//     @required this.onTabSelected, this.tabController,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return TabBar(
//       onTap: (index) => onTabSelected(BookTab.values[index]),
//      controller: tabController,
//        indicator: BoxDecoration(
//             borderRadius: BorderRadius.circular(18.0),
//             gradient: LinearGradient(
//               begin: Alignment.bottomRight,
//               end: Alignment.topLeft,
//               colors: <Color>[
//                 Colors.lightGreen[200],
//                 Colors.lightBlue[600],
//               ],
//             ),
//           ),
//           tabs: <Widget>[],
//     );
//   }
// }
