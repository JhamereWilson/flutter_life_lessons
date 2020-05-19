import 'package:firebase_flutter_life/Models/app_tab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class TabSelector extends StatelessWidget {
  final AppTab activeTab;
  final Function(AppTab) onTabSelected;

  TabSelector({
    Key key,
    @required this.activeTab,
    @required this.onTabSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: AppTab.values.indexOf(activeTab),
      onTap: (index) => onTabSelected(AppTab.values[index]),
      backgroundColor: Colors.white70,
      selectedItemColor: Colors.grey[800],
      items: AppTab.values.map((tab) {
        return BottomNavigationBarItem(
            icon: Icon(
              tab == AppTab.topics
                  ? Icons.home
                  : tab == AppTab.profile ? Icons.local_library : Icons.mic, size: 36,
            ),
            title: Text(
              tab == AppTab.topics
                  ? "Topics" : tab == AppTab.profile ? "Profile"
                  : "Recording",
            ));
      }).toList(),
    );
  }
}
