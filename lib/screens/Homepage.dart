import 'package:flutter/material.dart';
import 'package:infinits_v1/screens/TaskScreen.dart';
import 'package:infinits_v1/screens/login.dart';

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
          body: IndexedStack(
            index: currentstate,
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentstate,
            onTap: (value) {
              setState(() {
                currentstate = value;
                switch (currentstate) {
                  case 0:
                    setState(() {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Homepage()));
                    });
                    break;
                  case 1:
                    setState(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Attendance()));
                    });
                  case 2:
                    setState(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TaskScreen()));
                    });

                    break;
                  default:
                }
              });
            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_month), label: "Attendance"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.task_alt), label: "Task"),
            ],
          )),
    );
  }
}
