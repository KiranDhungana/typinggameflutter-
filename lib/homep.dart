import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:hexcolor/hexcolor.dart';
import 'package:type_speed/mainpage.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';

import "madeword.dart";
import 'package:url_launcher/url_launcher.dart';


import 'package:share/share.dart';

void main() {
   WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    theme: new ThemeData(scaffoldBackgroundColor: const Color(0xFFEFEFEF)),
    home: Mpage(),
  ));
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.transparent,
  ));
}

class Mpage extends StatefulWidget {
  const Mpage({key}) : super(key: key);

  @override
  _MpageState createState() => _MpageState();
}

class _MpageState extends State<Mpage> {
   bool _isInterstitialAdLoaded = false;
   @override
  void initState() {
    super.initState();

    FacebookAudienceNetwork.init(
      testingId: "939a8f8a-17ee-4d6a-b869-76d12031ccc6",
    );
    _loadInterstitialAd();
  }
   void _loadInterstitialAd() {
    FacebookInterstitialAd.loadInterstitialAd(
      placementId: "676347523535851_676361776867759",
      //"IMG_16_9_APP_INSTALL#2312433698835503_2650502525028617" YOUR_PLACEMENT_ID
      listener: (result, value) {
        //  AdSettings.addTestDevice("939a8f8a-17ee-4d6a-b869-76d12031ccc6");
        print(">> FAN > Interstitial Ad: $result --> $value");
        if (result == InterstitialAdResult.LOADED)
          _isInterstitialAdLoaded = true;

        /// Once an Interstitial Ad has been dismissed and becomes invalidated,
        /// load a fresh Ad by calling this function.
        if (result == InterstitialAdResult.DISMISSED &&
            value["invalidated"] == true) {
          _isInterstitialAdLoaded = false;
          _loadInterstitialAd();
          
        }
        
      },
    );
  }
   @override
  void dispose() {
//    myBanner.dispose();
//    myInterstitial.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    
    
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    
    return Scaffold(
          bottomNavigationBar: Container(
            color: Colors.transparent,
            height: MediaQuery.of(context).size.height * 0.07,
            child: FacebookBannerAd(
              // bro tyo hejo ko device id rw aaja ko device id eutai ho ni haii?
              keepAlive: true,
              placementId: "676347523535851_676352393535364",
              bannerSize: BannerSize.STANDARD,
              listener: (result, value) {
                print("Banner Ad: $result -->  $value");
              },
            )),
      body:
       Container(
        height: 1200,
        width: 800,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [HexColor("#ffafbd"), HexColor("#2193b0")],
        )),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Image.asset(
                "assets/ic.png",
                scale: 4,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 50.0,
                right: 50.0,
              ),
              child: Opacity(
                opacity: 0.8,
                child: Card(
                  elevation: 10,
                  color: HexColor("#2193b0"),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageRouteBuilder(
                              transitionDuration: Duration(milliseconds: 250),
                              transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) =>
                                  SlideTransition(
                                    position: Tween<Offset>(
                                      begin: const Offset(-1, 0),
                                      end: Offset.zero,
                                    ).animate(animation),
                                    child: child,
                                  ),
                              pageBuilder: (BuildContext context,
                                  Animation animation,
                                  Animation<double> secAnimation) {
                                return WordPhysicsAnimation();
                              }));
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.06,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: HexColor("#2193b0"),
                      ),
                      child: Center(
                        child: Text(
                          "Start Easy Mode",
                          style: GoogleFonts.abel(
                            textStyle: TextStyle(
                                color: Colors.white,
                                letterSpacing: .5,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50.0, right: 50.0, top: 25),
              child: Opacity(
                opacity: 0.8,
                child: Card(
                  elevation: 10,
                  color: HexColor("#2193b0"),
                  child: InkWell(
                    onTap: () {
                        // _loadInterstitialAd();
                      Navigator.push(
                          context,
                          PageRouteBuilder(
                              transitionDuration: Duration(milliseconds: 250),
                              transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) =>
                                  SlideTransition(
                                    position: Tween<Offset>(
                                      begin: const Offset(-1, 0),
                                      end: Offset.zero,
                                    ).animate(animation),
                                    child: child,
                                  ),
                              pageBuilder: (BuildContext context,
                                  Animation animation,
                                  Animation<double> secAnimation) {
                                return PhysicsAnimation();
                              }));
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.06,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: HexColor("#2193b0"),
                      ),
                      child: Center(
                        child: Text(
                          "Start Hard Mode",
                          style: GoogleFonts.abel(
                            textStyle: TextStyle(
                                color: Colors.white,
                                letterSpacing: .5,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50.0, right: 50.0, top: 25),
              child: Opacity(
                opacity: 0.8,
                child: InkWell(
                  onTap: () {
                      _loadInterstitialAd();
                    launch(
                        "https://play.google.com/store/apps/details?id=np.kirandhungana.speedtyping");
                  },
                  child: Card(
                    elevation: 10,
                    color: HexColor("#2193b0"),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.06,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: HexColor("#2193b0"),
                      ),
                      child: Center(
                        child: Text(
                          "Rate Us",
                          style: GoogleFonts.abel(
                            textStyle: TextStyle(
                                color: Colors.white,
                                letterSpacing: .5,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50.0, right: 50.0, top: 25),
              child: Opacity(
                opacity: 0.8,
                child: Card(
                  elevation: 10,
                  color: HexColor("#2193b0"),
                  child: InkWell(
                    onTap: () {
                           _loadInterstitialAd();
                      Share.share(
                          'Check Out the Game and increse Your typing skill https://play.google.com/store/apps/details?id=np.kirandhungana.speedtyping',
                          subject: 'Download the game Now');
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.06,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: HexColor("#2193b0"),
                      ),
                      child: Center(
                        child: Text(
                          "Share",
                          style: GoogleFonts.abel(
                            textStyle: TextStyle(
                                color: Colors.white,
                                letterSpacing: .5,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    
  }
    // ignore: unused_element
    _showInterstitialAd() {
    if (_isInterstitialAdLoaded == true)
      FacebookInterstitialAd.showInterstitialAd();
    else
      print("Interstial Ad not yet loaded!");
  }
}
  
  

