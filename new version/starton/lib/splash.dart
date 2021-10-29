import 'package:flutter/material.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'login.dart';
import 'home.dart';



class splash extends StatelessWidget {
  const splash({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  EasySplashScreen(
      backgroundColor: Colors.amber,
      durationInSeconds:4,
      navigator: home(),

      logo: Image.asset('assets/StartOn-logos_black.png',
        width:100,
        height: 100,
      ),
    );
  }
}