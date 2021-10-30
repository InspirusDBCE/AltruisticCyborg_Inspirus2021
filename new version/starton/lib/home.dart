import 'package:flutter/material.dart';
import 'package:shifting_tabbar/shifting_tabbar.dart';
import 'package:starton/discover.dart';
import 'package:starton/news.dart';
import 'package:starton/profile.dart';
import 'chat.dart';
import 'expert.dart';
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
        actions: [IconButton(onPressed:(){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => news()),
          );
        }, icon: Icon(Icons.new_releases_sharp),color: Colors.black,),],
        title: Text(
          'StartOn',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: DefaultTabController(
        length: 5,
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
              ShiftingTab(
                icon: const Icon(Icons.hail),
                text: 'Expert',
              ),


            ],
          ),
          // Other parts of the app are exacly same as default TabBar widget
          body: TabBarView(
            children: <Widget>[
              discover(),
              issue(),

              chat(),
              profile(),
              expert(),

            ],
          ),
        ),
      ),
    );
  }
}
