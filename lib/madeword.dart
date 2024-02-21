import 'dart:async';

import 'package:flutter/services.dart';
import 'package:vibration/vibration.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/physics.dart';

class WordPhysicsAnimation extends StatefulWidget {
  _WordPhysicsAnimation createState() => _WordPhysicsAnimation();
}

class _WordPhysicsAnimation extends State<WordPhysicsAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  GravitySimulation simulation;

  bool ispaused = false;

  TextEditingController cont = TextEditingController();
  double speed = 500.0;
  int i = 0;
  List<String> words = [
    "I",
    "WE",
    "Absolute",
    "Accept",
    "Across",
    "Adjust",
    "Advice",
    "Agree",
    "Album",
    "Arrive",
    "Association",
    "Auto draw",
    "Bag",
    "I love Typing",
    "What is App",
    "Am I Nepali",
    "A single Distinct",
    "The Dictionary added",
    "HOW TO USE WORDS",
    "The act of composing and Sending",
    "Governmental and non-governmental",
    "To send messages to mobile",
    "Developed in the early",
    "E-mail messaging from phones",
    "As a substitute for voice calls",
    "Making it their most frequent",
    "What is Phone",
    "Where can I buy Phone",
    "Do app make money ?",
    "Should I rate this app ?",
    "Yes You should rate this",
    "NEpal",
    "How To",
    "Computer",
    "Begging",
    "Home Is",
    "Are You GooD",
    "Book a Car 98",
    "Should I wrok",
    "better ThaN BEfore",
    "Loving Car",
    "Where Are You BG",
    "Start TypiInG",
    "Follow Me",
    "i neeD a B6",
    "F**k U",
    "Nepal Is",
    "Is it^",
    "Dancing",
    "FriEnds",
    "Go with Me",
    "I am WHeN Young!",
    "^786",
    "Good better BEst",
    "Is It GoOd",
    "HomeWroK is Easy",
    "FallinG in LovE",
    "Work Hard EveryDAy",
    "Easy COme and Easy Go",
    "I begging",
    "RARA is a Beautiful Place",
    "Be youR MaN",
    "7464566**",
    "%%%..",
    "jsdkd^^",
    "AppLICAtion",
    "HandlinG A GooD WorK",
    "Hand I am BE",
    "Live Young Wild ANd FrEE",
    "You Will Remember",
    "BeHiNd",
    "Where ARe YoU",
    "Make A Money",
    "Where Do You LiVE!",
    "IT iS a GooD BooK",
    "SEE The BeaUtY",
    "Love Me LiKE YoU Do^",
    "Quick BrowN",
    "Fox",
    "MAde In NEpal",
    "Book IS a nice weapOn",
    "Live aT PResENt",
    "Make A LifE BettEr",
    "DoG iS BaRKing",
    "WOW What A NiCE Car",
    ")(_+)(7",
    "5%R67*",
    "5464%467",
    "wORK hARd For SuccEss",
    "MoneY iS eVEry Thing",
    "Work HArd To SuceSS",
    "windowFocusChanged",
    "IInputConnectionWrapper makes",
    "Get the test",
    "addTestDevice",
    "Mediation Dashboard",
    "User not logged",
    "connEctiOn Is rEestablisHed",
    "Developer or Tester",
    "Products are GoOD",
    "To request a test ad",
    "As Michael Harvey writes",
    "Many novice writers",
    "You siMply caNnot cleArly",
    "YouR proFessoRs wiLl",
    "IN AcademiC wriTing",
    "onWindowFocusChangedFromViewRoot",
    "typically cOmpoSed oF",
    "KnowIng thIs ConvenTion",
    "SenTence-lEveL worDsmitHing",
    "CohesiOn reFers To the Flow",
    "For organIZatiOn and word",
    "A texT readS smootHly whEn",
    "ReAd aLl Of iT wiTh",
    "TellIng kEy seNteNce",
    "how epidemIologY",
    "BIoloGical PathwaY",
    "ParagraPh abOut celLs anD",
    "CleaRer Picture of How",
    "OnlY weaK ties",
    "StreNgth To Draw",
    "haVe Each Part",
    "sUcCessFul oRganically Struc",
    "pAraGraPh shOuld",
    "LICENSES AND ATTRIBUTIONS",
    "Message quEue sYnchronization"
    ];
  String data;
  //loop
  int changeword() {
    i = i + 1;
    return i;
    // ignore: dead_code
    setState(() {
      setCounterValue1();
    });
  }

  //geting score
  getintValue() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    int coun = pref.getInt('Counter');
    return coun;
  }

//setting score
  setintValue() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt('Counter', i);
  }

//check score
  checkintValue() async {
    int coun = await getCounterValue1() ?? 0;
    setState(() {
      i = coun;
    });
  }

  //Wright wrong main logic
  void logic() {
    if (cont.text == words[i]) {
      print("Correct");
      AssetsAudioPlayer.newPlayer()
          .open(Audio("assets/audio.m4a"), volume: 1.0);

      timer = 30;

      setState(() {
        data = words[changeword()];
        controller.animateWith(simulation);
        cont.clear();
        score1 = score1 + 1;
        setCounterValue1();
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
    checkcounterValue1();
    checkintValue();

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
                data = words[changeword()];
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
                data = words[changeword()];
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

  int score1 = 0;

  void dec() {
    setState(() {
      Future.delayed(const Duration(milliseconds: 400), () {
        score1 = score1 - 1;
      });

      setCounterValue1();
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
        score1 = score1 + 1;
      });

      setCounterValue1();
    });
  }

//geting score
  getCounterValue1() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    int count1 = pref.getInt('CounterValue1');
    return count1;
  }

//setting score
  setCounterValue1() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt('CounterValue1', score1);
  }

//check score
  checkcounterValue1() async {
    int count1 = await getCounterValue1() ?? 0;
    setState(() {
      score1 = count1;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    Future<bool> _back() {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Do you Want To Quit ?"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    child: Text("Yes")),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("No"))
              ],
            );
          });
    }

    return WillPopScope(
      onWillPop: _back,
      child: Scaffold(
        body: Stack(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 18),
                child: Container(
                  height: 45,
                  width: 45,
                  child: Center(
                    child: Text(
                      score1.toString(),
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
                  padding: const EdgeInsets.only(right: 15.0, top: 20),
                  child: Row(
                    children: [
                      Icon(
                        Icons.timer_sharp,
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
              child: Text(
                words[i],
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
