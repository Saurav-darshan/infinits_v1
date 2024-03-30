import 'dart:convert';
import 'dart:core';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:moment_dart/moment_dart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class test extends StatefulWidget {
  const test({super.key});

  @override
  State<test> createState() => _testState();
}

void sendattendance(String id, String intime, String outime, String token,
    DateTime date) async {
  Map<String, dynamic> jsonData = {
    "personnelId": id,
    "imageIn": "IMage URL",
    "imageOut": "image Url",
    "dateTimeIn": DateTime.now().toString(),
    "dateTimeOut": DateTime.now().toString(),
    "locationIn": {"lat": 25.6039167, "long": 25.6039167},
    "locationOut": {"lat": 25.6039167, "long": 25.6039167},
  };
  String jsonPayload = jsonEncode(jsonData);
  try {
    Response response = await post(
        Uri.parse("https://imapi.mybusi.net/api/admin/createAttendence"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
        body: jsonPayload);
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print(response.statusCode);
    }
  } catch (e) {
    print(e.toString());
  }
}

class _testState extends State<test> {
  String personnelID = "", inTime = "", outTime = "";
  String token = "";
  bool isClicked = false;
  DateTime date = DateTime.now();
  @override
  void initState() {
    getid();
    print("${DateTime.now().toMoment()}");
    print("${DateTime.now().runtimeType}");
    print("${DateTime.now().toMoment().runtimeType}");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: isClicked == false
                ? () {
                    clicked();
                    log("${isClicked}");
                    log(personnelID);
                    log(token);

                    sendattendance(personnelID, "", "2024-50-01T06:21:11.601",
                        token, date);
                  }
                : null,
            child: Text("hit me up")),
      ),
    );
  }

  void getid() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      personnelID = sp.getString("personnel_id")!.toString();
      token = sp.getString("accessToken")!.toString();
    });
  }

  void clicked() {
    setState(() {
      isClicked = true;
    });
  }
}
