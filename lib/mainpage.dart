import 'dart:async';
import 'package:flutter/services.dart';
import 'package:vibration/vibration.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:random_string/random_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/physics.dart';

class PhysicsAnimation extends StatefulWidget {
  _PhysicsAnimation createState() => _PhysicsAnimation();
}

class _PhysicsAnimation extends State<PhysicsAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  GravitySimulation simulation;

  bool ispaused = false;

  TextEditingController cont = TextEditingController();
  double speed = 500.0;
  void initstate(){
    super.initState();
    checkcounterValue();
  }

   String data =randomAlpha(4);
  
   
  

  //Wright wrong main logic
  void logic() {
    if (cont.text==data) {
      print("Correct");
      AssetsAudioPlayer.newPlayer()
          .open(Audio("assets/audio.m4a"), volume: 1.0);

      timer = 30;

      setState(() {
        
       
        data = randomAlpha(6);
        controller.animateWith(simulation);
        cont.clear();
        score = score + 1;
          setCounterValue();
          
      });
    } else {
      Vibration.vibrate(duration: 500); //Vibration
      _showMyDialog();

      print("Wrong");
    }
  }

  @override
  void initState() {
    super.initState();
    timercont();
    checkcounterValue();

    simulation = GravitySimulation(
      speed, // acceleration
      0.0,
      // starting point

      250, // end point
      0.0, // starting velocity
    );

    controller = AnimationController(vsync: this, upperBound: 500)
      ..addListener(() {
        setState(() {});
      });

    controller.animateWith(simulation);
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Wrong'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Your answer was wrong '),
                Text('Would you like to Continue to Next ?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                data =randomAlpha(4);
                controller.animateWith(simulation);
                cont.clear();
                dec();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showMyDialog2t() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Wrong'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Your Time is out '),
                Text('Would you like to Continue to Next ?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                data=randomAlpha(4);
                controller.animateWith(simulation);
                cont.clear();
                dec();
                Navigator.of(context).pop();
                timercont();
                setState(() {
                  timer = 30;
                });
              },
            ),
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
                timercont();
                setState(() {
                  timer = 30;
                });
              },
            ),
          ],
        );
      },
    );
  }

 
  int score = 0;
  int count;

  void dec() {
    setState(() {
      Future.delayed(const Duration(milliseconds: 400), () {
        score = score - 1;
      });

      setCounterValue();
    });
  }

//Timer change the time
  int timer = 30;
  String showTimer = "5";
  void timercont() {
    const onsec = Duration(seconds: 1);
    Timer.periodic(onsec, (Timer t) {
      setState(() {
        if (timer < 1) {
          t.cancel();
          _showMyDialog2t();
        } else {
          timer = timer - 1;
        }
        showTimer = timer.toString();
      });
    });
  }

//score increase function
  void increasenno() {
    setState(() {
      Future.delayed(const Duration(milliseconds: 400), () {
        score = score + 1;
      });

      setCounterValue();
    });
  }

//geting score
  getCounterValue() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    int count = pref.getInt('CounterValue');
    return count;
  }

//setting score
  setCounterValue() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt('CounterValue',score);
  }

//check score
  checkcounterValue() async {
    int count = await getCounterValue() ?? 0;
    setState(() {
      score =count;
    });
  }
  

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
       Future<bool> _backbt(){
  return showDialog(context: context, builder: (context){
    return AlertDialog(
      title: Text("Do you Want To Quit ?"
      
      ),
      actions: [
TextButton(onPressed:(){
  Navigator.pop(context,true);

}, child: Text("Yes")),

 TextButton(onPressed: (){
   Navigator.pop(context);

 }, child: Text("No"))

      ],



    );


  });
}


    
    return WillPopScope(
      onWillPop: _backbt,
      child: Scaffold(
        body: Stack(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 20),
                child: Container(
                  height: 45,
                  width: 45,
                  child: Center(
                    child: Text(
                      score.toString(),
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.black,
                          fontSize: 25),
                    ),
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.lightBlue, width: 2),
                    borderRadius: BorderRadius.circular(45),
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(
                    right: 15.0,top: 20
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.timer_sharp,
                      color: Colors.red,
                      ),
                      SizedBox(
                        width: 4,

                      ),
                      Text(
                        showTimer,
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                    ],
                  )),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 290),
            child: Scaffold(
                body: Padding(
              padding: const EdgeInsets.only(left: 5.0, right: 5),
              child: TextField(
                cursorColor: Colors.black,
                controller: cont,
                decoration: InputDecoration(
                  fillColor: Colors.grey,
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red)),
                  hintText: "Type Here !",
                  focusColor: Colors.red,
                  hoverColor: Colors.pink,
                  filled: true,
                  suffixIcon: IconButton(
                    onPressed: () {
                      logic();
                    
                    },
                    icon: Icon(Icons.navigate_next_sharp),
                    color: Colors.white,
                  ),
                ),
              ),
            )),
          ),
          Positioned(
            left: 20,
            top: controller.value,
            height: 30,
            width: double.maxFinite,
            child: Container(
              child: Text(data,
                style: GoogleFonts.abel(
                  textStyle: TextStyle(
                      color: Colors.blue, letterSpacing: .5, fontSize: 22),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

