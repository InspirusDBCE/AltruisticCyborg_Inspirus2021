import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'signup.dart';
import 'package:page_transition/page_transition.dart';

import 'home.dart';

class rlogin extends StatefulWidget {
  const rlogin({Key? key}) : super(key: key);

  @override
  _rloginState createState() => _rloginState();
}

class _rloginState extends State<rlogin> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // checkAuthetication();
  }

  showError(String errorMesssage) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(errorMesssage),
            actions: <Widget>[
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('ok')),
            ],
          );
        });
  }

  void signin() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }
    try {
      var users = await _auth.signInWithEmailAndPassword(
          email: _email, password: _password);
      Navigator.pushAndRemoveUntil<dynamic>(
        context,
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => home(),
        ),
            (route) => false, //if you want to disable back feature set to false
      );
    } on FirebaseAuthException catch (e) {
      showError(e.code);
    }
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email = "", _password = "";
  final FirebaseAuth _auth = FirebaseAuth.instance;
  void checkAuthetication() async {
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        Navigator.pushAndRemoveUntil<dynamic>(
          context,
          MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => home(),
          ),
              (route) => false, //if you want to disable back feature set to false
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.amber,
          body: SingleChildScrollView(
            child: Container(
              // decoration: BoxDecoration(
              //   image: DecorationImage(
              //     image: AssetImage("StartOn-logos_black.png"),
              //     fit: BoxFit.cover,
              //   ),
              // ),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset("assets/StartOn-logos_black.png",),
                  // SizedBox(
                  //   height: MediaQuery.of(context).size.height / 7,
                  // ),
                  // Text(
                  //   'SIGN IN',
                  //   style: TextStyle(
                  //     fontSize: 27,
                  //     fontWeight: FontWeight.w800,
                  //     color: Colors.white,
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 150,
                  // ),
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(40, 10, 40, 20),
                          child: TextFormField(
                            validator: (input) {
                              if (input!.isEmpty) {
                                return 'Provide an Email';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Colors.black, width: 1.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Colors.black, width: 1.0),
                              ),
                            ),
                            onSaved: (input) => _email = input!,
                            obscureText: false,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(40, 10, 40, 30),
                          child: TextFormField(
                            validator: (input) {
                              if (input!.isEmpty) {
                                return 'Provide an Password';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Colors.black, width: 1.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Colors.black, width: 1.0),
                              ),
                            ),
                            onSaved: (input) => _password = input!,
                            obscureText: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      signin();
                    },
                    child: Text(
                      'SIGN IN',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.fromLTRB(70, 10, 70, 10),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.topToBottom, child: signup()));
                    },
                    child: Text(
                      'SIGN UP',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.fromLTRB(70, 10, 70, 10),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              side: BorderSide(
                                color: Colors.black,
                                width: 2,
                              ))),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
