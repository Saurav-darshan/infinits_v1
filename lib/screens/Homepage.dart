import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int currentstate = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body: Text("home screen")));
  }
}
