import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Attendance extends StatefulWidget {
  const Attendance({super.key});

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  File? SelectedImages;
  String? Inimage, InTime, InDate;
  String? Outimage, OutTime, OutDate;
  double? latiin, latiout;
  double? longin, longout;
  bool isUserIn = false, isUserOut = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 145, 249, 148),
                  border: Border.all(
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  Inimage != null
                      ? Container(
                          width: 50,
                          height: 50,
                          padding: EdgeInsets.all(2),
                          margin: EdgeInsets.only(left: 5),
                          child: Image.file(
                              fit: BoxFit.fill, File(Inimage.toString())))
                      : Text("no Image found"),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text("Date :- ${InDate}"),
                          InTime != null
                              ? Text("IN Time :- ${InTime}")
                              : Text("No Time Found"),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          longin != null
                              ? Text("long = ${longin} \n lat = ${latiin}")
                              : Text("no location found"),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 249, 145, 145),
                  border: Border.all(
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  Outimage != null
                      ? Container(
                          width: 50,
                          height: 50,
                          padding: EdgeInsets.all(2),
                          margin: EdgeInsets.only(left: 5),
                          child: Image.file(
                              fit: BoxFit.fill, File(Outimage.toString())))
                      : Text("no data found"),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text("Date:- ${OutDate}"),
                          OutTime != null
                              ? Text("IN Time :- ${OutTime}")
                              : Text("No Time Found"),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          longout != null
                              ? Text("long = ${longout} \n lat = ${latiout}")
                              : Text("no location found"),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  pickImageFormCamerain();
                },
                child: Text("In")),
            ElevatedButton(
                onPressed: isUserIn == false
                    ? null
                    : () {
                        pickImageFormCameraout();
                      },
                child: Text("OUT")),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    FinalShow();
                  });
                },
                child: Text("show"))
          ],
        ),
      ),
    );
  }

//camera enable function :-
  Future pickImageFormCamerain() async {
    final ReturnedImageData =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (ReturnedImageData == null) {
      return;
    } else {
      setState(() {
        // SelectedImages = File(ReturnedImageData!.path);
        Inimage = ReturnedImageData.path;
        setinLocation();
        setinImage();
        InDate =
            "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year} ";
        isUserIn = true;
      });
    }
  }

//used to set data in sharedpreference
  setinImage() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString("imagepath", Inimage.toString());
    sp.setString("indate", InDate.toString());
  }

//used to get data from sharedpreference

  getinImage() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      Inimage = sp.getString("imagepath").toString();
      InDate = sp.getString("indate").toString();
    });
  }

//used to get location of the user and set it to sharedpref
  void setinLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      log("location denied");
      LocationPermission permission = await Geolocator.checkPermission();
    } else {
      Position currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      latiin = currentPosition.latitude;
      longin = currentPosition.longitude;
      InTime =
          "${DateTime.now().hour}: ${DateTime.now().minute}:${DateTime.now().second}";
      log("lat = ${currentPosition.latitude}\nlon= ${currentPosition.longitude}");
      SharedPreferences sp = await SharedPreferences.getInstance();
      sp.setDouble("latin", latiin!.toDouble());
      sp.setDouble("longin", longin!.toDouble());
      sp.setString("intime", InTime!.toString());
    }
  }

//get location value from shared prefrence
  getinLocation() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      latiin = sp.getDouble("latin")!.toDouble();
      longin = sp.getDouble("longin")!.toDouble();
      InTime = sp.getString("intime")!.toString();
    });
  }
  //*************************----OUT FUNCTION---***************************** */

  Future pickImageFormCameraout() async {
    final ReturnedImageData =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (ReturnedImageData == null) {
      return;
    } else {
      setState(() {
        // SelectedImages = File(ReturnedImageData!.path);
        Outimage = ReturnedImageData.path;
        OutDate =
            "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year} ";

        setoutLocation();
        setoutImage();
      });
    }
  }

  setoutImage() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString("imagepathout", Inimage.toString());
    sp.setString("outdate", OutDate.toString());
  }

  getoutImage() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      Outimage = sp.getString("imagepathout").toString();
      OutDate = sp.getString("outdate").toString();
    });
  }

  void setoutLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      log("location denied");
      LocationPermission permission = await Geolocator.checkPermission();
    } else {
      Position currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      latiout = currentPosition.latitude;
      longout = currentPosition.longitude;
      OutTime =
          "${DateTime.now().hour}: ${DateTime.now().minute}:${DateTime.now().second}";
      log("lat = ${currentPosition.latitude}\nlon= ${currentPosition.longitude}");
      SharedPreferences sp = await SharedPreferences.getInstance();
      sp.setDouble("latout", latiout!.toDouble());
      sp.setDouble("longout", longout!.toDouble());
      sp.setString("outtime", OutTime.toString());
    }
  }

//get location value from shared prefrence
  getoutLocation() async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    setState() {
      latiout = sp.getDouble("latiout")!.toDouble();
      longout = sp.getDouble("longout")!.toDouble();
      OutTime = sp.getString("outtime")!.toString();
    }
  }

  FinalShow() {
    getinImage();
    getinLocation();
    getoutImage();
    getoutImage();
  }
}
