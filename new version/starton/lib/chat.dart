import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:starton/mas.dart';

class chat extends StatefulWidget {

  const chat({Key? key}) : super(key: key);

  @override
  _chatState createState() => _chatState();
}

class _chatState extends State<chat> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final firestoreInstance = FirebaseFirestore.instance;
  late List<String> users = [];
  late List<String> names = [];
  late List<String> dUsers = [];

@override
  void initState() {
    // TODO: implement initState
    super.initState();


  firestoreInstance.collection("chatlist").get().then((querySnapshot) {
    querySnapshot.docs.forEach((result) {
      if ((result.data()['ruid']).toString() ==
          (_auth.currentUser!.uid.toString())) {
        users.add(result.data()['uid'].toString());
        // print(result.data()['uid'].toString());
      }
      if ((result.data()['uid']).toString() ==
          (_auth.currentUser!.uid.toString())) {
        users.add(result.data()['ruid'].toString());
        // print(result.data()['uid'].toString());
      }
    });
      setState(() {
        names =users.toSet().toList();
      });
  });




  //   firestoreInstance.collection("chatlist").get().then((querySnapshot) {
  //   querySnapshot.docs.forEach((result) {
  //     users.add(result.data()['ruid'].toString());
  //     // print(result.data()['uid'].toString());
  //   });
  // //     if ((result.data()['uid']).toString() ==
  // //         (_auth.currentUser!.uid.toString())) {
  // //       users.add(result.data()['ruid'].toString());
  // //       // print(result.data()['uid'].toString());
  // //     }});
  //

  //
  // });


//   for(var i = 0; i< dUsers.length; i++)
//   {
//     // print(dUsers[i].toString());
//
//
//     firestoreInstance.collection("UserData").get().then((querySnapshot) {
//       querySnapshot.docs.forEach((result) {
//         // print(result);
//         if(result.data()['userid']== dUsers[i].toString())
//         {
//           names.add(result.data()['name']);
//
//           print( names);
//
//         }
//
//       });
//
//
//
//
//     });
//
//
//
//     // var map =  firestoreInstance.collection("UserData").get().then((value) => value.docs.where((element) => element.data()['uid']==dUsers[i].toString()));
//     //  print(map.then((value) => print(value)));
//   }
  }

  @override
  Widget build(BuildContext context) {
    Query cData = FirebaseFirestore.instance
        .collection('UserData');





    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: cData.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {


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

                    child: GestureDetector(
                      onTap: (){
                        print(snapshot.data!.docs.elementAt(i).get('userid').toString());
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => mas(ruid: snapshot.data!.docs.elementAt(i).get('userid').toString())),
                        );


                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(

                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(90.0),
                                child: Image.network(
                                  snapshot.data!.docs.elementAt(i).get('photourl').toString(),
                                  width: 80.0,
                                  height: 80.0,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            SizedBox(width: 20,),
                              Align(alignment:Alignment.bottomCenter,child: Text(snapshot.data!.docs.elementAt(i).get('name').toString())),


                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );



        },),


    );


    /*Container(

      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
        itemCount: names.length,
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
                child: GestureDetector(
                  // onTap: Chatmsg(Text(names[i].toString())),
                  child: ListTile(

                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(names[i].toString()),


                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );*/
  }
}
