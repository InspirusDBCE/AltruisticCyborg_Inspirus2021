import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
    //Missue us = Missue(_uid, _issue, _skills.toString());
    Missue us = Missue("_uid", "_issue"," _skills.toString()");
    // Userinfo us = Userinfo(
    //     "12", "13", "swdss", "jdbhsb", 'assets/splash.png', "jsdnj", "dcfsdfs");

    await firestoreInstance.collection("Issue").add(us.toJson());

    // await _databaseReference.child('user').child(users.user!.uid).push().set(us.toJson());
    print("hello");
  }
  bool isLoading = true;
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
    return Scaffold(
      body: isLoading ? CircularProgressIndicator():Container(),
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
