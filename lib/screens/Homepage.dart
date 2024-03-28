import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int currentstate = 0;
  String person_name = "User";
  String image_uri = "";
  String roles = "";
  @override
  void initState() {
    Username();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Stack(children: [
      Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.blueAccent[700],
        child: Align(
          alignment: Alignment.topRight,
          child: Container(
            width: 65,
            height: 65,
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.orange[700],
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(60))),
          ),
        ),
        // child: Image.asset(
        //   "assets/bg3.jpeg",
        //   fit: BoxFit.cover,
        // ),
      ),
      Positioned(
        top: 40,
        left: 40,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Welcome !",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            Text(
              person_name,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
      Positioned(
        right: 20,
        top: 20,
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.all(2),
                width: 60,
                height: 60,
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                child: CircleAvatar(
                  foregroundImage: NetworkImage(
                      "https://imindsbucket.s3.ap-south-1.amazonaws.com/${image_uri}"),
                )

                //  Image.network(
                //     "https://imindsbucket.s3.ap-south-1.amazonaws.com/${image_uri}"),

                // "https://imapi.mybusi.net/${image_uri}"),
                ),
            Text(
              roles,
              style: TextStyle(
                // backgroundColor: Color.fromARGB(187, 0, 251, 255),
                color: Colors.white,
                fontSize: 10,
              ),
            )
          ],
        ),
      ),
      InkWell(
        onTap: () {
          Scaffold.of(context).openDrawer();
        },
        child: Padding(
          padding: EdgeInsets.only(left: 10, top: 10),
          child: Icon(
            Icons.menu_rounded,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          color: Colors.white,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 1.8,
          ),
        ),
      ),
    ])));
  }

  Future Username() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var name = sp.getString('person_name');
    var uri = sp.getString('image_uri');
    var role = sp.getString('role');

    setState(() {
      person_name = name!;
      image_uri = uri!;
      roles = role!;
    });
  }
}
