import 'package:flutter/material.dart';
import 'package:infinits_v1/screens/LoginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int currentstate = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: TextButton(
                onPressed: () async {
                  final SharedPreferences sp =
                      await SharedPreferences.getInstance();
                  sp.remove("isLogin");
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                child: Text("logout"))));
  }
}
