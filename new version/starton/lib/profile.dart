import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'login.dart';
import "package:url_launcher/url_launcher.dart";
import 'package:horizontal_card_pager/horizontal_card_pager.dart';
import 'package:horizontal_card_pager/card_item.dart';
import 'package:firebase_auth/firebase_auth.dart';

class profile extends StatefulWidget {
  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<profile> {
  late String uid;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String url1 = "oi",
      url2 = "oi",
      url3 = "oi",
      url4 = "oi";

  void checkAuthetication() async {
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.pushAndRemoveUntil<dynamic>(
          context,
          MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => rlogin(),
          ),
              (
              route) => false, //if you want to disable back feature set to false
        );
      }
    });
  }



  getdata() {}

  getuser() {}
bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //checkAuthetication();
    uid = _auth.currentUser!.uid;
    setState(() {
      isLoading = false;
    });

    print(uid);
  }

  @override
  Widget build(BuildContext context) {
    Query uData = FirebaseFirestore.instance
        .collection('UserData')
        .where("userid", isEqualTo: uid);

    return isLoading? CircularProgressIndicator() : StreamBuilder<QuerySnapshot>(
      stream: uData.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        // var skills = snapshot.data!.docs.elementAt(0).get('skills').toString();
        // List skillList = skills.replaceAll('[', "").replaceAll(']', "").split(',');

        if (snapshot.hasError) {
          return Text('Sorry, something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.8,
              child: Center(
                  child: CircularProgressIndicator(
                    valueColor:
                    new AlwaysStoppedAnimation<Color>(Colors.black),
                  )
              )
          );
        }

        if (!snapshot.hasData) {
          return Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.8,
              child: Center(child: Text("No Data Available")));
        }
        // return Container(
        //   // height: 780,
        //     child: Column(
        //         children: [
        //           Padding(
        //             padding: const EdgeInsets.only(top: 8.0),
        //             child: Container(
        //               child: Text(snapshot.data!.docs.elementAt(0).get('name').toString(),
        //                 style: TextStyle(fontSize: 15.0,
        //                     color: Colors.black54,
        //                     fontWeight: FontWeight.bold,
        //                     fontFamily: 'Times New Roman'),
        //               ),
        //             ),
        //           ),
        //         ]
        //     )
        // );


        return Column(
          children: [
            SizedBox(height: 20),
            ClipRRect(
              borderRadius: BorderRadius.circular(90.0),
              child: Image.asset(
                snapshot.data!.docs.elementAt(0).get('photourl').toString(),
                width: 110.0,
                height: 110.0,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(height: 15),
            Text(snapshot.data!.docs.elementAt(0).get('name').toString(), style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    icon: FaIcon(FontAwesomeIcons.github),
                    onPressed: () {
                      launch(snapshot.data!.docs.elementAt(0).get('github').toString());
                    }),
                IconButton(
                    icon: FaIcon(FontAwesomeIcons.linkedin),
                    onPressed: () {
                      launch(snapshot.data!.docs.elementAt(0).get('linked').toString());
                    }),
                IconButton(
                    icon: FaIcon(FontAwesomeIcons.mailBulk),
                    onPressed: () {
                      launch('mailto:'+ _auth.currentUser!.email.toString());
                    }),
                IconButton(
                    icon: FaIcon(FontAwesomeIcons.phone),
                    onPressed: () {
                      launch('tel://'+ snapshot.data!.docs.elementAt(0).get('contact').toString());
                    }),
              ],
            ),
            SizedBox(
              height: 15,
            ),

            Container(
              color: Colors.amber,
              height: 100,
              child: ListView.builder(
                itemCount: snapshot.data!.docs.elementAt(0).get('skills').toString().replaceAll('[', "").replaceAll(']', "").split(',').length,
                itemBuilder: (context, i) {
                  return ListTile(
                    title: Text(snapshot.data!.docs.elementAt(0).get('skills').toString().replaceAll('[', "").replaceAll(']', "").split(',')[i].toString()),
                  );
                },
              ),
            )
          ],
        );
      },);
  }
}
