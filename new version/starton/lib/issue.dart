import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'chatlist.dart';
import 'message.dart';
import 'missue.dart';

class issue extends StatefulWidget {
  @override
  _issueState createState() => _issueState();
}

class _issueState extends State<issue> {
  _openPopup(context) {
    Alert(
        context: context,
        title: "Issue",
        content: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextField(
                minLines: 2,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Issue',
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1.0),
                  ),
                ),
                onChanged: (value) => _issue = value,
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.only(right: 0, left: 0.0),
                child: MultiSelectFormField(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1.0),
                  ),
                  autovalidate: false,
                  chipBackGroundColor: Colors.amber,
                  chipLabelStyle: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                  dialogTextStyle: TextStyle(fontWeight: FontWeight.bold),
                  checkBoxActiveColor: Colors.amber,
                  checkBoxCheckColor: Colors.white,
                  dialogShapeBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0))),
                  title: Text(
                    "Keyword",
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                  ),
                  validator: (value) {
                    if (value == null || value.length == 0) {
                      return '';
                    }
                    return null;
                  },
                  dataSource: [
                    {
                      "display": "AI",
                      "value": "AI",
                    },
                    {
                      "display": "Machine Learning",
                      "value": "Machine Learning",
                    },
                    {
                      "display": "IOT",
                      "value": "IOT",
                    },
                    {
                      "display": "Web Development",
                      "value": "Web Development",
                    },
                    {
                      "display": "Mobile app development",
                      "value": "Mobile app development",
                    },
                  ],
                  textField: 'display',
                  valueField: 'value',
                  okButtonLabel: 'OK',
                  cancelButtonLabel: 'CANCEL',
                  hintWidget: Text(
                    'Please choose one or more',
                    style: TextStyle(
                      fontSize: 11,
                    ),
                  ),
                  initialValue: _skills,
                  onSaved: (value) {
                    if (value == null) return;
                    setState(() {
                      _skills = value;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        buttons: [
          DialogButton(
            color: Colors.amber,
            onPressed: () {
              svae();
              Navigator.pop(context);
            },
            child: Text(
              "Submit",
              style: TextStyle(color: Colors.black, fontSize: 11),
            ),
          )
        ]).show();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final firestoreInstance = FirebaseFirestore.instance;
  late String _uid;
  late String _issue;
  List? _skills;

  void svae() async {
    Missue us = Missue(_uid, _issue, _skills.toString());
    // Missue us = Missue("_uid", "_issue"," _skills.toString()");
    // Userinfo us = Userinfo(
    //     "12", "13", "swdss", "jdbhsb", 'assets/splash.png', "jsdnj", "dcfsdfs");

    await firestoreInstance.collection("Issue").add(us.toJson());

    // await _databaseReference.child('user').child(users.user!.uid).push().set(us.toJson());
    print("hello");
  }

  bool isLoading = true;
  late String ch;
  addchatlist(String uid,String ruid) async{
    Chatlist us = Chatlist(uid, ruid);
    await firestoreInstance.collection("chatlist").add(us.toJson());
  }
  sendmessage(String uid,String ruid)async{
    if(uid.compareTo(ruid)>0 || uid.compareTo(ruid)==0){
      ch=uid+ruid;
    }else{
      ch=ruid+uid;
    }
    Message us =Message("hey",uid,ruid,DateTime.now().toString(),ch);
    await firestoreInstance.collection("chat").add(us.toJson());
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _uid = _auth.currentUser!.uid;
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Query sData = FirebaseFirestore.instance
        .collection('Issue');
    // print(sData.snapshots().);
 late List<String> uids = [];
    // for(var i =0 ; i<3;i++) {
    //   uids.add(sData.snapshots().forEach((element) {
    //     element.docs.forEach((element) {
    //       element.get('uid');
    //     });
    //   }).toString());
    // }
    Query uData = FirebaseFirestore.instance
        .collection('UserData')
        .where("userid", isEqualTo: uids);



    return Scaffold(
    body: isLoading ? Center(child: CircularProgressIndicator()):

    StreamBuilder<QuerySnapshot>(
    stream: sData .snapshots(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

    // print(snapshot.data!.docs.iterator.current);
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


    return Container(

    height: MediaQuery.of(context).size.height,
    child: ListView.builder(
    itemCount: snapshot.data!.docs.length,
    itemBuilder: (context, i) {
    return Padding(
    padding: const EdgeInsets.all(12.0),
    child: Container(

    decoration: BoxDecoration(
    color: Colors.grey.shade300,
    boxShadow: [
    BoxShadow(
    color: Colors.black26,
    offset: const Offset(
    5.0,
    5.0,
    ),
    blurRadius: 10.0,
    spreadRadius: 2.0,
    ), //BoxShadow
    BoxShadow(
    color: Colors.white,
    offset: const Offset(0.0, 0.0),
    blurRadius: 0.0,
    spreadRadius: 0.0,
    ), //BoxShadow
    ],
    borderRadius: BorderRadius.all(Radius.circular(10.0))
    ),

    child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: ListTile(

    title: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Text(snapshot.data!.docs.elementAt(i).get('issue').toString()),
    IconButton(splashColor: Colors.black26,onPressed: (){
      addchatlist(_uid,snapshot.data!.docs.elementAt(i).get('uid').toString());
      sendmessage(_uid,snapshot.data!.docs.elementAt(i).get('uid').toString());
    }, icon: Icon(Icons.chat))

    ],
    ),
    ),
    ),
    ),
    );
    },
    ),
    );


    Column(
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
    },),

    floatingActionButton: FloatingActionButton(
    onPressed: () {
    print("hellow");
    _openPopup(context);
    },
    child: Icon(
    Icons.add,
    ),
    backgroundColor: Colors.amber,
    ),
    );
  }
}
