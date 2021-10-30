import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Users.dart';
import 'dart:math';
// import 'package:meetup/photoup.dart';
import 'login.dart';
import 'package:page_transition/page_transition.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';

class signup extends StatefulWidget {
  const signup({Key? key}) : super(key: key);

  @override
  _signupState createState() => _signupState();
}

class _signupState extends State<signup> {
  List? _myActivities;
  late String _myActivitiesResult;
  final formKey = new GlobalKey<FormState>();
  bool flag = true;
  final fieldText = TextEditingController();
  final fieldText1 = TextEditingController();

  final fieldText2 = TextEditingController();

  void clearText() {
    fieldText.clear();
    fieldText1.clear();
    fieldText2.clear();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // this.checkAuthetication();
    _myActivities = [];
    _myActivitiesResult = '';
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final firestoreInstance = FirebaseFirestore.instance;
  String _email = "",
      _password = "",
      _contact = "",
      _name = "",
      _github = "",
      _linked = "",
      _description = "";
  String s = "Interest";
  final FirebaseAuth _auth = FirebaseAuth.instance;

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

  void svae(UserCredential users) async {
    Random random = new Random();
    int randomNumber = random.nextInt(10);
    Userinfo us = Userinfo(users.user!.uid, _contact, _github, _linked,
        'https://i.pravatar.cc/150?img='+randomNumber.toString(), _name, _myActivitiesResult, _description);
    //
    // Userinfo us = Userinfo(
    //     "12", "13", "swdss", "jdbhsb", 'assets/splash.png', "jsdnj", "dcfsdfs");

    await firestoreInstance.collection("UserData").add(us.toJson());

    // await _databaseReference.child('user').child(users.user!.uid).push().set(us.toJson());
    print("hello");
  }

  void signup() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        UserCredential users = await _auth.createUserWithEmailAndPassword(
            email: _email, password: _password);
        setState(() {
          _myActivitiesResult = _myActivities.toString();
        });
        svae(users);

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
  }

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

  // _saveForm() {
  //   var form = formKey.currentState!;
  //   if (form.validate()) {
  //     form.save();
  //     setState(() {
  //       _myActivitiesResult = _myActivities.toString();
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: flag ? Container(
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage("assets/slpash.png"),
        //     fit: BoxFit.cover,
        //   ),
        // ),
        // width: MediaQuery.of(context).size.width,
        // height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 35,
            ),
            Image(
              image: AssetImage('assets/StartOn-logos_black.png'),
              width: 150,
              height: 150,
            ),
            SizedBox(
              height: 10,
            ),
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                    child: TextFormField(
                      controller: fieldText,
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
                      onChanged: (input)=>{
                        setState(() {
                          _email = input;
                        })
                      },

                      // onSaved: (input) => _email = input!,
                      obscureText: false,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
//                   Container(
//                     padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
//                     child: TextFormField(
//                       validator: (input) {
//                         if (input!.isEmpty) {
//                           return 'Provide an name';
//                         }
//                         return null;
//                       },
//                       decoration: InputDecoration(
//                         labelText: 'Full name',
//                         labelStyle: TextStyle(
//                           color: Colors.black,
//                           fontSize: 17,
//                           fontWeight: FontWeight.w700,
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide:
//                               BorderSide(color: Colors.black, width: 1.0),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderSide:
//                               BorderSide(color: Colors.black, width: 1.0),
//                         ),
//                       ),
//                       onSaved: (input) => _name = input!,
//                       obscureText: false,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//
//                   Container(
//                     padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
//                     child: TextFormField(
//                       validator: (input) {
//                         if (input!.isEmpty) {
//                           return 'Provide an name';
//                         }
//                         return null;
//                       },
//                       decoration: InputDecoration(
//                         labelText: 'Contact',
//                         labelStyle: TextStyle(
//                           color: Colors.black,
//                           fontSize: 17,
//                           fontWeight: FontWeight.w700,
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide:
//                               BorderSide(color: Colors.black, width: 1.0),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderSide:
//                               BorderSide(color: Colors.black, width: 1.0),
//                         ),
//                       ),
//                       onSaved: (input) => _contact = input!,
//                       obscureText: false,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Container(
//                     padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
//                     child: TextFormField(
//                       validator: (input) {
//                         if (input!.isEmpty) {
//                           return 'Provide an name';
//                         }
//                         return null;
//                       },
//                       decoration: InputDecoration(
//                         labelText: 'Github',
//                         labelStyle: TextStyle(
//                           color: Colors.black,
//                           fontSize: 17,
//                           fontWeight: FontWeight.w700,
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide:
//                               BorderSide(color: Colors.black, width: 1.0),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderSide:
//                               BorderSide(color: Colors.black, width: 1.0),
//                         ),
//                       ),
//                       onSaved: (input) => _github = input!,
//                       obscureText: false,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Container(
//                     padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
//                     child: TextFormField(
//                       validator: (input) {
//                         if (input!.isEmpty) {
//                           return 'Provide an name';
//                         }
//                         return null;
//                       },
//                       decoration: InputDecoration(
//                         labelText: 'LinkedIn',
//                         labelStyle: TextStyle(
//                           color: Colors.black,
//                           fontSize: 17,
//                           fontWeight: FontWeight.w700,
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide:
//                               BorderSide(color: Colors.black, width: 1.0),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderSide:
//                               BorderSide(color: Colors.black, width: 1.0),
//                         ),
//                       ),
//                       onSaved: (input) => _linked = input!,
//                       obscureText: false,
//                     ),
//                   ),
//
//                   Container(
//                     padding: EdgeInsets.only(right: 40.0, left: 40.0),
//                     child: MultiSelectFormField(
//                       border: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.black, width: 1.0),
//                       ),
//                       autovalidate: false,
//                       chipBackGroundColor: Colors.blue,
//                       chipLabelStyle: TextStyle(
//                           fontWeight: FontWeight.bold, color: Colors.white),
//                       dialogTextStyle: TextStyle(fontWeight: FontWeight.bold),
//                       checkBoxActiveColor: Colors.amber,
//                       checkBoxCheckColor: Colors.white,
//                       dialogShapeBorder: RoundedRectangleBorder(
//                           borderRadius:
//                               BorderRadius.all(Radius.circular(12.0))),
//                       title: Text(
//                         "Skills",
//                         style: TextStyle(
//                             fontSize: 17, fontWeight: FontWeight.bold),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.length == 0) {
//                           return 'Please select one or more options';
//                         }
//                         return null;
//                       },
//                       dataSource: [
//                         {
//                           "display": "AI",
//                           "value": "AI",
//                         },
//                         {
//                           "display": "IOT",
//                           "value": "IOT",
//                         },
//                         {
//                           "display": "Web Development",
//                           "value": "Web Development",
//                         },
//                         {
//                           "display": "Mobile app development",
//                           "value": "Mobile app development",
//                         },
//                       ],
//                       textField: 'display',
//                       valueField: 'value',
//                       okButtonLabel: 'OK',
//                       cancelButtonLabel: 'CANCEL',
//                       hintWidget: Text('Please choose one or more'),
//                       initialValue: _myActivities,
//                       onSaved: (value) {
//                         if (value == null) return;
//                         setState(() {
//                           _myActivities = value;
//                         });
//                       },
//                     ),
//                   ),
// // Container(
// //   padding: EdgeInsets.all(8),
// //   child: ElevatedButton(
// //     child: Text('Save'),
// //     onPressed: _saveForm,
// //   ),
// // ),
// //
//                   SizedBox(
//                     height: 10,
//                   ),

                  Container(
                    padding: EdgeInsets.fromLTRB(40, 10, 40, 30),
                    child: TextFormField(
                      controller: fieldText1,
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
                      onChanged: (input)=>{
                        setState(() {
                          _password = input;
                        })
                      },
                      // onSaved: (input) => _password = input!,
                      obscureText: true,
                    ),
                  ),


                  Container(
                    padding: EdgeInsets.fromLTRB(40, 10, 40, 30),
                    child: TextFormField(
                      maxLines: 6,
                      minLines: 2,
                      controller: fieldText2,
                      decoration: InputDecoration(
                        labelText: 'Description',
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
                      onChanged: (input)=>{
                        setState(() {
                          _description = input;
                        })
                      },
                      // onSaved: (input) => _password = input!,
                    ),
                  ),




                ],
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                clearText();
                // print(_email +_password);
              setState(() {

                // (input) => _email = input;
                // (input) => _password = input;
                flag= false;
              });
              },
              child: Icon(Icons.arrow_forward),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.amber),
                padding: MaterialStateProperty.all<EdgeInsets>(
                  EdgeInsets.fromLTRB(70, 10, 70, 10),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),








            // ElevatedButton(
            //   onPressed: () {
            //     // _saveForm();
            //     signup();
            //   },
            //   child: Text(
            //     'SIGN UP',
            //     style: TextStyle(
            //       fontSize: 20,
            //       fontWeight: FontWeight.w800,
            //     ),
            //   ),
            //   style: ButtonStyle(
            //     backgroundColor:
            //         MaterialStateProperty.all<Color>(Colors.red.shade400),
            //     padding: MaterialStateProperty.all<EdgeInsets>(
            //       EdgeInsets.fromLTRB(70, 10, 70, 10),
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   height: 20,
            // ),
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.push(
            //         context,
            //         PageTransition(
            //             type: PageTransitionType.bottomToTop, child: rlogin()));
            //   },
            //   child: Text(
            //     'SIGN IN',
            //     style: TextStyle(
            //       fontSize: 20,
            //       fontWeight: FontWeight.w800,
            //       color: Colors.red.shade300,
            //     ),
            //   ),
            //   style: ButtonStyle(
            //       backgroundColor:
            //           MaterialStateProperty.all<Color>(Colors.white),
            //       padding: MaterialStateProperty.all<EdgeInsets>(
            //         EdgeInsets.fromLTRB(70, 10, 70, 10),
            //       ),
            //       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            //           RoundedRectangleBorder(
            //               side: BorderSide(
            //         color: Colors.red.shade300,
            //         width: 2,
            //       )))),
            // ),
          ],
        ),
      ):


      Container(
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage("assets/slpash.png"),
        //     fit: BoxFit.cover,
        //   ),
        // ),
        // width: MediaQuery.of(context).size.width,
        // height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 35,
            ),
            Image(
              image: AssetImage('assets/StartOn-logos_black.png'),
              width: 150,
              height: 150,
            ),
            SizedBox(
              height: 10,
            ),
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  // Container(
                  //   padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                  //   child: TextFormField(
                  //     validator: (input) {
                  //       if (input!.isEmpty) {
                  //         return 'Provide an Email';
                  //       }
                  //       return null;
                  //     },
                  //     decoration: InputDecoration(
                  //       labelText: 'Email',
                  //       labelStyle: TextStyle(
                  //         color: Colors.black,
                  //         fontSize: 17,
                  //         fontWeight: FontWeight.w700,
                  //       ),
                  //       focusedBorder: OutlineInputBorder(
                  //         borderSide:
                  //         BorderSide(color: Colors.black, width: 1.0),
                  //       ),
                  //       enabledBorder: OutlineInputBorder(
                  //         borderSide:
                  //         BorderSide(color: Colors.black, width: 1.0),
                  //       ),
                  //     ),
                  //     onSaved: (input) => _email = input!,
                  //     obscureText: false,
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  Container(
                    padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                    child: TextFormField(

                      validator: (input) {
                        if (input!.isEmpty) {
                          return 'Provide an name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Full name',
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
                      onSaved: (input) => _name = input!,
                      obscureText: false,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  Container(
                    padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                    child: TextFormField(
                      validator: (input) {
                        if (input!.isEmpty) {
                          return 'Provide an name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Contact',
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
                      onSaved: (input) => _contact = input!,
                      obscureText: false,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                    child: TextFormField(
                      validator: (input) {
                        if (input!.isEmpty) {
                          return 'Provide an name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Github',
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
                      onSaved: (input) => _github = input!,
                      obscureText: false,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                    child: TextFormField(
                      validator: (input) {
                        if (input!.isEmpty) {
                          return 'Provide an name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'LinkedIn',
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
                      onSaved: (input) => _linked = input!,
                      obscureText: false,
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.only(right: 40.0, left: 40.0),
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
                          borderRadius:
                          BorderRadius.all(Radius.circular(12.0))),
                      title: Text(
                        "Skills",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      validator: (value) {
                        if (value == null || value.length == 0) {
                          return 'Please select one or more options';
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
                      hintWidget: Text('Please choose one or more'),
                      initialValue: _myActivities,
                      onSaved: (value) {
                        if (value == null) return;
                        setState(() {
                          _myActivities = value;
                        });
                      },
                    ),
                  ),
// Container(
//   padding: EdgeInsets.all(8),
//   child: ElevatedButton(
//     child: Text('Save'),
//     onPressed: _saveForm,
//   ),
// ),
//
                  SizedBox(
                    height: 10,
                  ),

                  // Container(
                  //   padding: EdgeInsets.fromLTRB(40, 10, 40, 30),
                  //   child: TextFormField(
                  //     validator: (input) {
                  //       if (input!.isEmpty) {
                  //         return 'Provide an Password';
                  //       }
                  //       return null;
                  //     },
                  //     decoration: InputDecoration(
                  //       labelText: 'Password',
                  //       labelStyle: TextStyle(
                  //         color: Colors.black,
                  //         fontSize: 17,
                  //         fontWeight: FontWeight.w700,
                  //       ),
                  //       focusedBorder: OutlineInputBorder(
                  //         borderSide:
                  //         BorderSide(color: Colors.black, width: 1.0),
                  //       ),
                  //       enabledBorder: OutlineInputBorder(
                  //         borderSide:
                  //         BorderSide(color: Colors.black, width: 1.0),
                  //       ),
                  //     ),
                  //     onSaved: (input) => _password = input!,
                  //     obscureText: true,
                  //   ),
                  // ),
                ],
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // _saveForm();
                signup();
              },
              child: Text(
                'SIGN UP',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
              style: ButtonStyle(
                backgroundColor:
                MaterialStateProperty.all<Color>(Colors.amber),
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
                        type: PageTransitionType.bottomToTop, child: rlogin()));
              },
              child: Text(
                'SIGN IN',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Colors.red.shade300,
                ),
              ),
              style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.white),
                  padding: MaterialStateProperty.all<EdgeInsets>(
                    EdgeInsets.fromLTRB(70, 10, 70, 10),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          side: BorderSide(
                            color: Colors.amber,
                            width: 2,
                          )))),
            ),
          ],
        ),
      ),


    ));
  }
}
