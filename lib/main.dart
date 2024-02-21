// ignore: unused_import
import 'dart:async';

import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:type_speed/homep.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  )
  );
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.transparent,
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    Widget example1 = SplashScreenView(
      navigateRoute: Mpage(),
      duration: 5000,
      imageSize: 200,
      imageSrc: "assets/ic.png",
      text: "Speed Typing",
      textType: TextType.ColorizeAnimationText,
      textStyle: TextStyle(fontSize: 40.0, fontWeight: FontWeight.w400),
      colors: [
        Colors.pink,
        Colors.black,
        Colors.yellow,
        Colors.red,
      ],
      backgroundColor: Colors.white,
    );

    return 
    
    MaterialApp(
      
      title: 'Splash screen Demo',
      home: example1,
    );
  }
}
