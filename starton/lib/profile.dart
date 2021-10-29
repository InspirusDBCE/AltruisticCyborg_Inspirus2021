import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:starton/rloging.dart';
import "package:url_launcher/url_launcher.dart";
import 'package:horizontal_card_pager/horizontal_card_pager.dart';
import 'package:horizontal_card_pager/card_item.dart';
import 'package:firebase_auth/firebase_auth.dart';

class profile extends StatefulWidget {
  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<profile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String url1 = "oi", url2 = "oi", url3 = "oi", url4 = "oi";

  void checkAuthetication() async {
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.pushAndRemoveUntil<dynamic>(
          context,
          MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => rlogin(),
          ),
          (route) => false, //if you want to disable back feature set to false
        );
      }
    });
  }

  List<String> Skills = ["hey", "hi"];
  getdata() {}
  getuser() {}
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //checkAuthetication();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        ClipRRect(
          borderRadius: BorderRadius.circular(90.0),
          child: Image.asset(
            'assets/1.jpg',
            width: 110.0,
            height: 110.0,
            fit: BoxFit.fill,
          ),
        ),
        SizedBox(height: 15),
        Text('Elon Musk', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                icon: FaIcon(FontAwesomeIcons.github),
                onPressed: () {
                  launch(url1);
                }),
            IconButton(
                icon: FaIcon(FontAwesomeIcons.linkedin),
                onPressed: () {
                  launch(url2);
                }),
            IconButton(
                icon: FaIcon(FontAwesomeIcons.mailBulk),
                onPressed: () {
                  launch(url3);
                }),
            IconButton(
                icon: FaIcon(FontAwesomeIcons.phone),
                onPressed: () {
                  launch(url4);
                }),
          ],
        ),
        SizedBox(
          height: 15,
        ),
        SizedBox(height: 15),
        // ListView.builder(
        //   itemCount: Skills.length,
        //   itemBuilder: (context, i) {
        //     return ListTile(
        //       title: Text(Skills[i].toString()),
        //     );
          //},
        )
      ],
    );
  }
}
