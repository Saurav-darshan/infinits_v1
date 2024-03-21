import 'dart:async';

import 'package:flutter/material.dart';
import 'package:infinits_v1/screens/LandingPage.dart';
import 'package:infinits_v1/screens/LoginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late String? finalloginDetail;
  void initState() {
    super.initState();
    isLogin().whenComplete(() async {
      Timer(Duration(seconds: 3), () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    finalloginDetail == null ? LoginScreen() : Landingpage()));
      });
    });
  }

  Future isLogin() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var obtained_detail = sp.getString('isLogin');
    setState(() {
      finalloginDetail = obtained_detail;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Image.asset(
                "assets/backl.png",
                fit: BoxFit.fitHeight,
              ),
              color: Colors.white,
            ),
            Align(
              alignment: Alignment(0, -.3),
              child: Image.asset(
                "assets/im_sq.png",
                scale: 3,
                color: Colors.black,
              ),
            ),
            Align(
              alignment: Alignment(0, -.3),
              child: Image.asset(
                "assets/test.png",
                scale: 1.45,

                //color: Colors.black,
              ),
            ),
            Align(
              alignment: Alignment(0, .48),
              child: CircularProgressIndicator(
                color: Colors.green[800],
              ),
            )
          ],
        ),
      ),
    );
  }
}
