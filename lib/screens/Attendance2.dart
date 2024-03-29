import 'dart:developer';
import 'dart:io';

import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class attend extends StatefulWidget {
  const attend({super.key});

  @override
  State<attend> createState() => _attendState();
}

class _attendState extends State<attend> {
  File? SelectedImages;
  String? Inimage, InTime, InDate;
  String? Outimage, OutTime, OutDate;
  String? Inlocation, OutLocation;
  double? latiin, latiout;
  double? longin, longout;
  bool isUserIn = false, isUserOut = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(color: Colors.orangeAccent),
            child: Container(
              margin: EdgeInsets.only(top: 30),
              child: EasyDateTimeLine(
                initialDate: DateTime.now(),
                onDateChange: (selectedDate) {
                  //print(DateFormat.yMd(selectedDate));
                },
                dayProps: EasyDayProps(
                    dayStructure: DayStructure.monthDayNumDayStr,
                    todayHighlightStyle: TodayHighlightStyle.withBackground,
                    todayHighlightColor: Color.fromARGB(255, 62, 7, 120),
                    todayNumStyle: TextStyle(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        fontSize: 40,
                        fontWeight: FontWeight.w700)),
                headerProps: EasyHeaderProps(
                  dateFormatter: DateFormatter.fullDateDayAsStrMY(),
                ),
              ),
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
                color: Colors.black,
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
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              color: Colors.white,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.65,
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        "Start Your Day...!",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            decoration: TextDecoration.underline),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    const Color.fromARGB(255, 136, 255, 140)),
                                foregroundColor:
                                    MaterialStatePropertyAll(Colors.black),
                                elevation: MaterialStatePropertyAll(5),
                              ),
                              onPressed: () {
                                pickImageFormCamerain();
                              },
                              child: Text("IN")),
                          ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    isUserIn == true
                                        ? Color.fromARGB(255, 255, 136, 136)
                                        : Colors.grey),
                                foregroundColor:
                                    MaterialStatePropertyAll(Colors.black),
                                elevation: MaterialStatePropertyAll(5),
                              ),
                              onPressed: isUserIn == false
                                  ? null
                                  : () {
                                      pickImageFormCameraout();
                                    },
                              child: Text("OUT")),
                        ],
                      ),
                      // Container(
                      //   width: MediaQuery.of(context).size.width,
                      //   margin: EdgeInsets.all(8.0),
                      //   decoration: BoxDecoration(
                      //       color: Color.fromARGB(255, 145, 249, 148),
                      //       border: Border.all(
                      //         width: 1.0,
                      //       ),
                      //       borderRadius: BorderRadius.circular(10)),
                      //   child: Row(
                      //     children: [
                      //       Inimage != null
                      //           ? Container(
                      //               width: 50,
                      //               height: 50,
                      //               padding: EdgeInsets.all(2),
                      //               margin: EdgeInsets.only(left: 5),
                      //               child: Image.file(
                      //                   fit: BoxFit.fill,
                      //                   File(Inimage.toString())))
                      //           : Text("no Image found"),
                      //       Column(
                      //         crossAxisAlignment: CrossAxisAlignment.center,
                      //         children: [
                      //           Row(
                      //             children: [
                      //               Text("Date :- ${InDate}"),
                      //               SizedBox(
                      //                 width: 60,
                      //               ),
                      //               InTime != null
                      //                   ? Text(
                      //                       "IN Time :- ${InTime}",
                      //                       style: TextStyle(
                      //                           fontWeight: FontWeight.bold),
                      //                     )
                      //                   : Text("No Time Found"),
                      //             ],
                      //           ),
                      //           Row(
                      //             mainAxisAlignment:
                      //                 MainAxisAlignment.spaceBetween,
                      //             children: [
                      //               longin != null
                      //                   ? Text(
                      //                       "long = ${longin} \t lat = ${latiin}")
                      //                   : Text("no location found"),
                      //             ],
                      //           )
                      //         ],
                      //       )
                      //     ],
                      //   ),
                      // ),

                      // //OUT UI
                      // Container(
                      //   width: MediaQuery.of(context).size.width,
                      //   margin: EdgeInsets.all(8.0),
                      //   decoration: BoxDecoration(
                      //       color: Color.fromARGB(255, 249, 145, 145),
                      //       border: Border.all(
                      //         width: 1.0,
                      //       ),
                      //       borderRadius: BorderRadius.circular(10)),
                      //   child: Row(
                      //     children: [
                      //       Outimage != null
                      //           ? Container(
                      //               width: 50,
                      //               height: 50,
                      //               padding: EdgeInsets.all(2),
                      //               margin: EdgeInsets.only(left: 5),
                      //               child: Image.file(
                      //                   fit: BoxFit.fill,
                      //                   File(Outimage.toString())))
                      //           : Text("no data found"),
                      //       Column(
                      //         crossAxisAlignment: CrossAxisAlignment.center,
                      //         children: [
                      //           Row(
                      //             children: [
                      //               Text("Date:- ${OutDate}"),
                      //               SizedBox(
                      //                 width: 60,
                      //               ),
                      //               OutTime != null
                      //                   ? Text(
                      //                       "Out Time :- ${OutTime}",
                      //                       style: TextStyle(
                      //                           fontWeight: FontWeight.bold),
                      //                     )
                      //                   : Text("No Time Found"),
                      //             ],
                      //           ),
                      //           Row(
                      //             mainAxisAlignment:
                      //                 MainAxisAlignment.spaceBetween,
                      //             children: [
                      //               longout != null
                      //                   ? Text(
                      //                       "long = ${longout} \t lat = ${latiout}")
                      //                   : Text("no location found"),
                      //             ],
                      //           )
                      //         ],
                      //       )
                      //     ],
                      //   ),
                      // ),

                      Card(
                        elevation: 10,
                        margin: EdgeInsets.only(left: 10, right: 10, top: 20),
                        color: Color.fromARGB(255, 216, 249, 221),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              border:
                                  Border.all(width: 1, color: Colors.black)),
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  padding: EdgeInsets.only(right: 10, left: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.greenAccent[400],
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          bottomLeft: Radius.circular(30))),
                                  child: Text("IN time"),
                                ),
                              ),
                              Align(
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage:
                                          FileImage(File(Inimage.toString())),
                                      radius: 30,
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.timer_outlined),
                                        Text(
                                          "${InTime}",
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.location_on),
                                        Text(
                                          "Long = ${longin} \t Lati = ${latiin}",
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.pin_drop),
                                        Text(
                                          "${Inlocation}",
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      //out-------------------->

                      Card(
                        elevation: 10,
                        margin: EdgeInsets.only(left: 10, right: 10, top: 20),
                        color: Color.fromARGB(255, 249, 216, 216),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              border:
                                  Border.all(width: 1, color: Colors.black)),
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  padding: EdgeInsets.only(right: 10, left: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          bottomLeft: Radius.circular(30))),
                                  child: Text(
                                    "OUT Time",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              Align(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    CircleAvatar(
                                      backgroundImage:
                                          FileImage(File(Outimage.toString())),
                                      radius: 30,
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.timer_outlined),
                                        Text(
                                          "${OutTime}",
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.location_on),
                                        Text(
                                          "Long = ${longout} \t Lati = ${latiout}",
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.pin_drop),
                                        Text("${OutLocation}"),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
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
        // setinLocation();
        setinImage();
        InDate =
            "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year} ";
        isUserIn = true;
        InTime = "${DateFormat('jms').format(DateTime.now())}";

        // "${DateTime.now().hour}: ${DateTime.now().minute}:${DateTime.now().second}";
      });
    }
  }

//used to set data in sharedpreference
  setinImage() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString("imagepath", Inimage.toString());
    sp.setString("indate", InDate.toString());
    sp.setString("intime", InTime!.toString());
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
      List<Placemark> placemark = await placemarkFromCoordinates(
          currentPosition.latitude, currentPosition.longitude);
      String inLocation =
          "${placemark[0].thoroughfare},${placemark[0].subLocality},${placemark[0].locality} ${placemark[0].postalCode}";

      log("lat = ${currentPosition.latitude}\nlon= ${currentPosition.longitude}");
      SharedPreferences sp = await SharedPreferences.getInstance();
      sp.setDouble("latin", latiin!.toDouble());
      sp.setDouble("longin", longin!.toDouble());
      sp.setString("inlocation", inLocation!.toString());
      getinImage();
    }
  }

//used to get data from sharedpreference

  getinImage() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      Inimage = sp.getString("imagepath").toString();
      InDate = sp.getString("indate").toString();
      InTime = sp.getString("intime")!.toString();
      latiin = sp.getDouble("latin")!.toDouble();
      longin = sp.getDouble("longin")!.toDouble();
      Inlocation = sp.getString("inlocation")!.toString();
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
        OutTime = "${DateFormat('jms').format(DateTime.now())}";
        //"${DateTime.now().hour}: ${DateTime.now().minute}:${DateTime.now().second}";

        setoutImage();
      });
    }
  }

  setoutImage() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString("imagepathout", Inimage.toString());
    sp.setString("outdate", OutDate.toString());
    sp.setString("outtime", OutTime.toString());
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
      List<Placemark> placemark = await placemarkFromCoordinates(
          currentPosition.latitude, currentPosition.longitude);
      String outLocation =
          "${placemark[0].thoroughfare},${placemark[0].subLocality},${placemark[0].locality} ${placemark[0].postalCode}";

      log("lat = ${currentPosition.latitude}\nlon= ${currentPosition.longitude}");
      SharedPreferences sp = await SharedPreferences.getInstance();
      sp.setDouble("latiout", latiout!.toDouble());
      sp.setDouble("longout", longout!.toDouble());
      sp.setString("outlocation", outLocation!.toString());

      getoutImage();
    }
  }

  getoutImage() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      Outimage = sp.getString("imagepathout").toString();
      OutDate = sp.getString("outdate").toString();
      OutTime = sp.getString("outtime")!.toString();
      latiout = sp.getDouble("latiout")!.toDouble();
      longout = sp.getDouble("longout")!.toDouble();
      OutLocation = sp.getString("outlocation")!.toString();
    });
  }

  FinalShow() {
    getinImage();
    // getinLocation();
    getoutImage();
    // getoutLocation();
  }
}
