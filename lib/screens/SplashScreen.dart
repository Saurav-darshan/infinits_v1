import 'dart:async';

import 'package:flutter/material.dart';
import 'package:infinits_v1/screens/LoginPage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
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
