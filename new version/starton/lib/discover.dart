import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class discover extends StatefulWidget {
  const discover({Key? key}) : super(key: key);

  @override
  _discoverState createState() => _discoverState();
}


class _discoverState extends State<discover> {
  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //checkAuthetication();
    // uid = _auth.currentUser!.uid;
    setState(() {
      isLoading = false;
    });


  }

  @override

  Widget build(BuildContext context) {
    Query uData = FirebaseFirestore.instance
        .collection('UserData');


    return isLoading? Center(child: CircularProgressIndicator()) : StreamBuilder<QuerySnapshot>(
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


        return Container(

          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, i) {
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
height: 200,
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
                            Column(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.network(snapshot.data!.docs.elementAt(i).get('photourl').toString()),
                                Text(snapshot.data!.docs.elementAt(i).get('name').toString()),
                                



                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(width:150,child: Text(snapshot.data!.docs.elementAt(i).get('description').toString())),
                                Container(
                                  width: 100,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(Icons.addchart_sharp),
                                      Icon(Icons.chat),
                                    ],
                                  ),
                                )
                              ],
                            )
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
