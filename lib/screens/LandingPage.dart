import 'package:flutter/material.dart';
import 'package:infinits_v1/screens/Attendance2.dart';
import 'package:infinits_v1/screens/Homepage.dart';
import 'package:infinits_v1/screens/LoginPage.dart';
import 'package:infinits_v1/screens/TaskScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Landingpage extends StatefulWidget {
  const Landingpage({super.key});

  @override
  State<Landingpage> createState() => _LandingpageState();
}

class _LandingpageState extends State<Landingpage> {
  int currentstate = 0;
  List<Widget> widgetList = [Homepage(), attend(), TaskScreen()];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(children: [
          IndexedStack(
            children: widgetList,
            index: currentstate,
          ),
        ]),
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
        drawer: Drawer(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          elevation: 0,
          width: MediaQuery.of(context).size.width / 1.5,
          child: ListView(
            children: [
              ListTile(
                title: Image.asset(
                  "assets/im_main.png",
                  scale: 2,
                ),
                onTap: () {},
              ),
              ListTile(
                title: Divider(
                  thickness: 2,
                  color: const Color.fromARGB(255, 0, 0, 0),
                  endIndent: double.minPositive,
                ),
              ),
              ListTile(
                title: Row(
                  children: [
                    Icon(Icons.person),
                    Text("Dashboard"),
                  ],
                ),
                onTap: () {},
              ),
              ListTile(
                title: Text("Work"),
                onTap: () {},
              ),
              ListTile(
                title: Text("Task"),
                onTap: () {},
              ),
              ListTile(
                title: Text("Mentions"),
                onTap: () {},
              ),
              ListTile(
                title: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromARGB(255, 2, 90, 255)),
                      foregroundColor: MaterialStatePropertyAll(Colors.white),
                    ),
                    onPressed: () async {
                      final SharedPreferences sp =
                          await SharedPreferences.getInstance();
                      sp.remove("isLogin");
                      sp.remove("person_name");
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    },
                    child: Text(
                      "Logout",
                      style: TextStyle(fontSize: 15),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
