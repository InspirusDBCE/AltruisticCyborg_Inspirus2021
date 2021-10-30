import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class mas extends StatefulWidget {

  const mas({Key? key,required this.ruid}) : super(key: key);
  final String ruid;
  @override
  _masState createState() => _masState();
}

class _masState extends State<mas> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String uid,ruid,ch;
  void initState() {
    // TODO: implement initState

    uid = _auth.currentUser!.uid.toString();

    super.initState();

    ruid = widget.ruid;
    if(uid.compareTo(ruid)>0 || uid.compareTo(ruid)==0){
      ch=uid+ruid;
    }else{
      ch=ruid+uid;
    }
    print(ch);
    // isLoading = false;
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    Query mData = FirebaseFirestore.instance.collection('chat');
    // print(mData.snapshots().first.then((value) => print(value.docs.length)));

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                StreamBuilder<QuerySnapshot>(
                  stream: mData.snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    // print(snapshot.data!.docs);


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

                                  title: Column(
                                    children: [
                                      Text(
                                        snapshot.data!.docs.elementAt(i).get('msg').toString(),
                                      ),
                                      SizedBox(width: 20,),




                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),

                    );



                  },),
                Container(
                  margin: EdgeInsets.all(15.0),
                  height: 61,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(35.0),
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0, 3),
                                  blurRadius: 5,
                                  color: Colors.grey)
                            ],
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                  icon: Icon(Icons.face , color: Colors.blueAccent,), onPressed: () {}),
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                      hintText: "Type Something...",
                                      hintStyle: TextStyle( color:     Colors.blueAccent),
                                      border: InputBorder.none),
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.photo_camera ,  color: Colors.blueAccent),
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: Icon(Icons.attach_file ,  color: Colors.blueAccent),
                                onPressed: () {},
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 15),
                      Container(
                        padding: const EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                            color: Colors.blueAccent, shape: BoxShape.circle),
                        child: InkWell(
                          child: Icon(
                            Icons.keyboard_voice,
                            color: Colors.white,
                          ),
                          onLongPress: () {
                          },
                        ),
                      )
                    ],
                  ),
                ) ,
              ],
            ),

          ),
        ),
      ),
    );
  }
}
