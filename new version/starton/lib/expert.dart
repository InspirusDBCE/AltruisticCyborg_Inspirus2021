import 'package:flutter/material.dart';
class expert extends StatefulWidget {
  const expert({Key? key}) : super(key: key);

  @override
  _expertState createState() => _expertState();
}

class _expertState extends State<expert> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:Column(
        children: [
          Container(
            color:Colors.red,
            padding: EdgeInsets.all(10),
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Start-Ups',
                style:TextStyle(
                  color:Colors.white,
                  fontWeight: FontWeight.bold,
                )
                ),
                Text('Fees',
                    style:TextStyle(
                      color:Colors.white,
                      fontWeight: FontWeight.bold,
                    )
                ),

              ],
            ),
          ),
          Container(
            color:Colors.red,
            padding: EdgeInsets.all(10),
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('OYO',
                    style:TextStyle(
                      color:Colors.white,
                      fontWeight: FontWeight.bold,
                    )
                ),
                Text('1200rs',
                    style:TextStyle(
                      color:Colors.white,
                      fontWeight: FontWeight.bold,
                    )
                ),

              ],
            ),
          )
        ],
      ),
    );
  }
}
