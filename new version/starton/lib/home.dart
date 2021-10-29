import 'package:flutter/material.dart';
import 'package:shifting_tabbar/shifting_tabbar.dart';
import 'package:starton/profile.dart';
import 'issue.dart';

class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(
          'StartOn',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: DefaultTabController(
        length: 4,
        child: Scaffold(
          // Use ShiftingTabBar instead of appBar
          appBar: ShiftingTabBar(
            // Specify a color to background or it will pick it from primaryColor of your app ThemeData
            color: Colors.white,
            // You can change brightness manually to change text color style to dark and light or
            // it will decide based on your background color
            // brightness: Brightness.dark,
            tabs: <ShiftingTab>[
              // Also you should use ShiftingTab widget instead of Tab widget to get shifting animation
              ShiftingTab(
                icon: const Icon(Icons.home),
                text: 'Home',
              ),
              ShiftingTab(
                icon: const Icon(Icons.lightbulb),
                text: 'Issue',
              ),
              ShiftingTab(
                icon: const Icon(Icons.message),
                text: 'chat',
              ),
              ShiftingTab(
                icon: const Icon(Icons.supervised_user_circle),
                text: 'Profile',
              ),
            ],
          ),
          // Other parts of the app are exacly same as default TabBar widget
          body: TabBarView(
            children: <Widget>[
              Icon(Icons.directions_bike),
              issue(),

              Icon(Icons.directions_car),
              profile(),
            ],
          ),
        ),
      ),
    );
  }
}
