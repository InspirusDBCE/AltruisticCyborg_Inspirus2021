
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webviewx/webviewx.dart';
class news extends StatefulWidget {
  const news({Key? key}) : super(key: key);

  @override
  _newsState createState() => _newsState();
}

class _newsState extends State<news> {
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