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
  Map<String, dynamic> InData = {
    "personnelId": id,
    "imageIn": "IMage URL",
    "imageOut": "image Url",
    "dateTimeIn": DateTime.now().toString(),
    "dateTimeOut": DateTime.now().toString(),
    "locationIn": {"lat": 25.6039167, "long": 25.6039167},
    "locationOut": {"lat": 25.6039167, "long": 25.6039167},
  };
  String jsonINPayload = jsonEncode(InData);
  try {
    Response response = await post(
        Uri.parse("https://imapi.mybusi.net/api/admin/createAttendence"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
        body: jsonINPayload);
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print(response.statusCode);
    }
  } catch (e) {
    print(e.toString());
  }
}

//---------------------IN -----------------------------\\

void SaveInAttendance(String AccessToken, String Personnel_id, String Inimage,
    String Indatetime, String Inlat, String Inlong) async {
  Map<String, dynamic> InData = {
    "personnelId": Personnel_id,
    "imageIn": Inimage,
    "dateTimeIn": Indatetime,
    "locationIn": {"lat": Inlat, "long": Inlong},
  };
  String jsonINPayload = jsonEncode(InData);
  try {
    Response response = await post(
        Uri.parse("https://imapi.mybusi.net/api/admin/createAttendence"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $AccessToken'
        },
        body: jsonINPayload);
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print(response.statusCode);
    }
  } catch (e) {
    print(e.toString());
  }
}

//--------------------------------------------------\\

//----------------------OUT ----------------------------\\
void SaveOutAttendance(
  String AccessToken,
  String Personnel_id,
  String Outimage,
  String Outdatetime,
  String Outlat,
  String Outlong,
) async {
  Map<String, dynamic> InData = {
    "personnelId": Personnel_id,
    "imageOut": Outimage,
    "dateTimeOut": Outdatetime,
    "locationOut": {"lat": Outlat, "long": Outlong},
  };
  String jsonINPayload = jsonEncode(InData);
  try {
    Response response = await put(
        Uri.parse("https://imapi.mybusi.net/api/admin/createAttendence"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $AccessToken'
        },
        body: jsonINPayload);
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print(response.statusCode);
    }
  } catch (e) {
    print(e.toString());
  }
}
//--------------------------------------------------\\

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
