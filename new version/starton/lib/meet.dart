import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webviewx/webviewx.dart';
class meet extends StatefulWidget {
  const meet({Key? key}) : super(key: key);

  @override
  _meetState createState() => _meetState();
}

class _meetState extends State<meet> {
  late WebViewXController webviewController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(
          'StartOn',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: WebViewX(
          initialContent: 'https://www.business-standard.com/category/companies-start-ups-up-corner-1011302.htm',

          onWebViewCreated: (controller) => webviewController = controller,

           width:MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height
      )
    );
  }
}