import 'package:flutter/material.dart';
import 'package:infinits_v1/screens/Attendance.dart';
import 'package:infinits_v1/screens/Homepage.dart';
import 'package:infinits_v1/screens/TaskScreen.dart';

class Landingpage extends StatefulWidget {
  const Landingpage({super.key});

  @override
  State<Landingpage> createState() => _LandingpageState();
}

class _LandingpageState extends State<Landingpage> {
  int currentstate = 0;
  List<Widget> widgetList = [Homepage(), Attendance(), TaskScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        children: widgetList,
        index: currentstate,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            currentstate = value;
          });
        },
        currentIndex: currentstate,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month), label: "Attendance"),
          BottomNavigationBarItem(icon: Icon(Icons.task_alt), label: "Task"),
        ],
      ),
    );
  }
}
