import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
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
  String? PersonalId;
  String? AccessToken;
  String request_id = "";

  @override
  void initState() {
    getid();
    getpermission();
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
                    monthPickerType: MonthPickerType.switcher),
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
                padding: EdgeInsets.only(left: 20, right: 20),
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
                          isUserIn == false
                              ? Expanded(
                                  child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                const Color.fromARGB(
                                                    255, 136, 255, 140)),
                                        foregroundColor:
                                            MaterialStatePropertyAll(
                                                Colors.black),
                                        elevation: MaterialStatePropertyAll(5),
                                      ),
                                      onPressed: () {
                                        pickImageFormCamerain();
                                      },
                                      child: Text("IN")),
                                )
                              : SizedBox(),
                          isUserOut == true || isUserIn == false
                              ? const SizedBox()
                              : Expanded(
                                  child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                isUserIn == true
                                                    ? Color.fromARGB(
                                                        255, 255, 136, 136)
                                                    : Colors.grey),
                                        foregroundColor:
                                            MaterialStatePropertyAll(
                                                Colors.black),
                                        elevation: MaterialStatePropertyAll(5),
                                      ),
                                      onPressed: isUserIn == false
                                          ? null
                                          : () {
                                              pickImageFormCameraout();
                                            },
                                      child: Text("OUT")),
                                ),
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

        //s3Upload(Inimage!);
        // uploadImageToS3(ReturnedImageData);

        ///-----------------------------------------
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
    SaveInAttendance(AccessToken!, PersonalId!, Inimage!,
        DateTime.now().toString(), latiin!, longin!);
  }
  //*************************----OUT FUNCTION---***************************** */

  Future pickImageFormCameraout() async {
    //------------------> camera for out Data
    final ReturnedImageData =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (ReturnedImageData == null) {
      return;
    } else {
      setState(() {
        Outimage = ReturnedImageData.path;
        OutDate =
            "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year} ";
        OutTime = "${DateFormat('jms').format(DateTime.now())}";

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
    SaveOutAttendance(AccessToken!, PersonalId!, Outimage!,
        DateTime.now().toString(), latiout!, longout!, request_id);
  }

  FinalShow() {
    getinImage();
    getoutImage();
  }

//----------Sending IN Data to Server------------------\\
//
//
//
  void SaveInAttendance(String AccessToken, String Personnel_id, String Inimage,
      String Indatetime, double Inlat, double Inlong) async {
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
        Map body = jsonDecode(response.body);
        log("${body["data"]["id"]}");
        SharedPreferences sp = await SharedPreferences.getInstance();
        sp.setString('attendance_id', body["data"]["id"].toString());
        setState(() {
          request_id = sp.getString('attendance_id').toString();
        });

        final Welcome_Snack = SnackBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            content: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.green[700],
              ),
              height: 30,
              child: Text(
                "${body["message"]}",
                style: TextStyle(),
              ),
            ));
        ScaffoldMessenger.of(context).showSnackBar(Welcome_Snack);
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e.toString());
    }
  }

//---------------------------------------------\\

  void SaveOutAttendance(
    String AccessToken,
    String Personnel_id,
    String Outimage,
    String Outdatetime,
    double Outlat,
    double Outlong,
    String id,
  ) async {
    Map<String, dynamic> InData = {
      "imageOut": Outimage,
      "dateTimeOut": Outdatetime,
      "locationOut": {"lat": Outlat, "long": Outlong},
    };
    String jsonINPayload = jsonEncode(InData);
    log("${request_id}");
    try {
      Response response = await put(
          Uri.parse("https://imapi.mybusi.net/api/admin/updateAttendence/$id"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $AccessToken'
          },
          body: jsonINPayload);
      if (response.statusCode == 200) {
        print(response.body);
        Map body = jsonDecode(response.body);
        final update_Snack = SnackBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            content: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.green[700],
              ),
              height: 30,
              child: Text(
                "${body["message"]}",
                style: TextStyle(),
              ),
            ));
        ScaffoldMessenger.of(context).showSnackBar(update_Snack);
        setState(() {
          isUserOut = true;
        });
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e.toString());
    }
  }
//---------------------------------------------\\

  void getid() async {
    //used to get personnel id & access token
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      PersonalId = sp.getString("personnel_id")!.toString();
      AccessToken = sp.getString("accessToken")!.toString();
    });
  }

  void getpermission() async {
    await Permission.camera.request();
    await Permission.locationWhenInUse.request();
  }

  // void s3Upload(String path) async {
  //   var url = "https://imindsbucket.s3.ap-south-1.amazonaws.com/";
  //   var request = MultipartRequest('POST', Uri.parse(url));
  //   request.files.add(await MultipartFile.fromPath('file', path));
  //   request.fields.addAll({'key': path.split('/').last, 'acl': 'public-read'});
  //   var msg = await request.send();
  // }

  // void uploadImageToS3(XFile imageFile) async {
  //   // Replace these values with your S3 bucket details
  //   String bucketName = 'imindsbucket';
  //   String region = 'ap-south-1';
  //   String accessKeyId = 'AKIA56YG5RQZES5PHOHM';
  //   String secretAccessKey = 'lLWX111qmDGLKNMnckK8PmHQwcmsGEXOirGM+zeL';

  //   String url =
  //       'https://$bucketName.s3.$region.amazonaws.com/${DateTime.now()}.jpg';

  //   Response response = await put(
  //     Uri.parse(url),
  //     headers: {
  //       'Content-Type': 'multipart/form-data',
  //       'x-amz-acl': 'public-read',
  //       'Authorization': 'AWS $accessKeyId:$secretAccessKey',
  //     },
  //     body: await imageFile.readAsBytes(),
  //   );

  //   if (response.statusCode == 200) {
  //     print('Image uploaded successfully!');
  //   } else {
  //     print('Failed to upload image. Status code: ${response.statusCode}');
  //   }
  // }
}
