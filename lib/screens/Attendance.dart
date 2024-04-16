// import 'dart:developer';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:syncfusion_flutter_calendar/calendar.dart';

// class Attendance extends StatefulWidget {
//   const Attendance({super.key});

//   @override
//   State<Attendance> createState() => _AttendanceState();
// }

// class _AttendanceState extends State<Attendance> {
//   File? SelectedImages;
//   String? Inimage, InTime, InDate;
//   String? Outimage, OutTime, OutDate;
//   double? latiin, latiout;
//   double? longin, longout;
//   bool isUserIn = false, isUserOut = false;

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Container(
//           // height: MediaQuery.of(context).size.height,

//           decoration: BoxDecoration(
//               shape: BoxShape.rectangle,
//               image: DecorationImage(
//                   image: AssetImage("assets/bg4.jpg"), fit: BoxFit.fill)),
//           child: Column(
//             children: [
//               Container(
//                 height: MediaQuery.of(context).size.height / 2.5,
//                 child: SfCalendar(
//                   view: CalendarView.month,
//                   firstDayOfWeek: 1,
//                   backgroundColor: Color.fromARGB(95, 255, 255, 255),
//                   headerStyle: CalendarHeaderStyle(
//                       backgroundColor: Color.fromARGB(255, 66, 53, 145),
//                       textStyle: TextStyle(color: Colors.white)),
//                   cellBorderColor: Color.fromARGB(71, 0, 0, 0),
//                   cellEndPadding: BorderSide.strokeAlignCenter,
//                   initialDisplayDate: DateTime.timestamp(),
//                   initialSelectedDate: DateTime.now(),
//                   showDatePickerButton: true,
//                   allowViewNavigation: false,
//                   showNavigationArrow: true,
//                 ),
//               ),
//               SizedBox(
//                 height: 30,
//               ),
//               Text(
//                 "Attendance Record",
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//               ),
//               SizedBox(
//                 height: 30,
//               ),
//               Container(
//                 width: MediaQuery.of(context).size.width,
//                 margin: EdgeInsets.all(8.0),
//                 decoration: BoxDecoration(
//                     color: Color.fromARGB(255, 145, 249, 148),
//                     border: Border.all(
//                       width: 1.0,
//                     ),
//                     borderRadius: BorderRadius.circular(10)),
//                 child: Row(
//                   children: [
//                     Inimage != null
//                         ? Container(
//                             width: 50,
//                             height: 50,
//                             padding: EdgeInsets.all(2),
//                             margin: EdgeInsets.only(left: 5),
//                             child: Image.file(
//                                 fit: BoxFit.fill, File(Inimage.toString())))
//                         : Text("no Image found"),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Row(
//                           children: [
//                             Text("Date :- ${InDate}"),
//                             SizedBox(
//                               width: 80,
//                             ),
//                             InTime != null
//                                 ? Text(
//                                     "IN Time :- ${InTime}",
//                                     style:
//                                         TextStyle(fontWeight: FontWeight.bold),
//                                   )
//                                 : Text("No Time Found"),
//                           ],
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             longin != null
//                                 ? Text("long = ${longin} \t lat = ${latiin}")
//                                 : Text("no location found"),
//                           ],
//                         )
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//               Container(
//                 width: MediaQuery.of(context).size.width,
//                 margin: EdgeInsets.all(8.0),
//                 decoration: BoxDecoration(
//                     color: Color.fromARGB(255, 249, 145, 145),
//                     border: Border.all(
//                       width: 1.0,
//                     ),
//                     borderRadius: BorderRadius.circular(10)),
//                 child: Row(
//                   children: [
//                     Outimage != null
//                         ? Container(
//                             width: 50,
//                             height: 50,
//                             padding: EdgeInsets.all(2),
//                             margin: EdgeInsets.only(left: 5),
//                             child: Image.file(
//                                 fit: BoxFit.fill, File(Outimage.toString())))
//                         : Text("no data found"),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Row(
//                           children: [
//                             Text("Date:- ${OutDate}"),
//                             SizedBox(
//                               width: 80,
//                             ),
//                             OutTime != null
//                                 ? Text(
//                                     "Out Time :- ${OutTime}",
//                                     style:
//                                         TextStyle(fontWeight: FontWeight.bold),
//                                   )
//                                 : Text("No Time Found"),
//                           ],
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             longout != null
//                                 ? Text("long = ${longout} \t lat = ${latiout}")
//                                 : Text("no location found"),
//                           ],
//                         )
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 80,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   ElevatedButton(
//                       style: ButtonStyle(
//                         backgroundColor: MaterialStatePropertyAll(
//                             const Color.fromARGB(255, 136, 255, 140)),
//                         foregroundColor: MaterialStatePropertyAll(Colors.black),
//                         elevation: MaterialStatePropertyAll(5),
//                       ),
//                       onPressed: () {
//                         pickImageFormCamerain();
//                       },
//                       child: Text("IN")),
//                   ElevatedButton(
//                       style: ButtonStyle(
//                         backgroundColor: MaterialStatePropertyAll(
//                             Color.fromARGB(255, 255, 136, 136)),
//                         foregroundColor: MaterialStatePropertyAll(Colors.black),
//                         elevation: MaterialStatePropertyAll(5),
//                       ),
//                       onPressed: isUserIn == false
//                           ? null
//                           : () {
//                               pickImageFormCameraout();
//                             },
//                       child: Text("OUT")),
//                 ],
//               ),
//               ElevatedButton(
//                   style: ButtonStyle(
//                     backgroundColor: MaterialStatePropertyAll(
//                         Color.fromARGB(255, 138, 220, 255)),
//                     foregroundColor: MaterialStatePropertyAll(Colors.black),
//                     elevation: MaterialStatePropertyAll(5),
//                   ),
//                   onPressed: () {
//                     setState(() {
//                       FinalShow();
//                     });
//                   },
//                   child: Text("Show Records"))
//             ],
//           ),
//         ),
//       ),
//     );
//   }

// //camera enable function :-
//   Future pickImageFormCamerain() async {
//     final ReturnedImageData =
//         await ImagePicker().pickImage(source: ImageSource.camera);
//     if (ReturnedImageData == null) {
//       return;
//     } else {
//       setState(() {
//         // SelectedImages = File(ReturnedImageData!.path);
//         Inimage = ReturnedImageData.path;
//         // setinLocation();
//         setinImage();
//         InDate =
//             "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year} ";
//         isUserIn = true;
//         InTime =
//             "${DateTime.now().hour}: ${DateTime.now().minute}:${DateTime.now().second}";
//       });
//     }
//   }

// //used to set data in sharedpreference
//   setinImage() async {
//     SharedPreferences sp = await SharedPreferences.getInstance();
//     sp.setString("imagepath", Inimage.toString());
//     sp.setString("indate", InDate.toString());
//     sp.setString("intime", InTime!.toString());
//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied ||
//         permission == LocationPermission.deniedForever) {
//       log("location denied");
//       LocationPermission permission = await Geolocator.checkPermission();
//     } else {
//       Position currentPosition = await Geolocator.getCurrentPosition(
//           desiredAccuracy: LocationAccuracy.best);
//       latiin = currentPosition.latitude;
//       longin = currentPosition.longitude;

//       log("lat = ${currentPosition.latitude}\nlon= ${currentPosition.longitude}");
//       SharedPreferences sp = await SharedPreferences.getInstance();
//       sp.setDouble("latin", latiin!.toDouble());
//       sp.setDouble("longin", longin!.toDouble());
//     }
//   }

// //used to get data from sharedpreference

//   getinImage() async {
//     SharedPreferences sp = await SharedPreferences.getInstance();
//     setState(() {
//       Inimage = sp.getString("imagepath").toString();
//       InDate = sp.getString("indate").toString();
//       InTime = sp.getString("intime")!.toString();
//       latiin = sp.getDouble("latin")!.toDouble();
//       longin = sp.getDouble("longin")!.toDouble();
//     });
//   }
//   //*************************----OUT FUNCTION---***************************** */

//   Future pickImageFormCameraout() async {
//     final ReturnedImageData =
//         await ImagePicker().pickImage(source: ImageSource.camera);
//     if (ReturnedImageData == null) {
//       return;
//     } else {
//       setState(() {
//         // SelectedImages = File(ReturnedImageData!.path);
//         Outimage = ReturnedImageData.path;
//         OutDate =
//             "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year} ";
//         OutTime =
//             "${DateTime.now().hour}: ${DateTime.now().minute}:${DateTime.now().second}";

//         setoutImage();
//       });
//     }
//   }

//   setoutImage() async {
//     SharedPreferences sp = await SharedPreferences.getInstance();
//     sp.setString("imagepathout", Inimage.toString());
//     sp.setString("outdate", OutDate.toString());
//     sp.setString("outtime", OutTime.toString());
//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied ||
//         permission == LocationPermission.deniedForever) {
//       log("location denied");
//       LocationPermission permission = await Geolocator.checkPermission();
//     } else {
//       Position currentPosition = await Geolocator.getCurrentPosition(
//           desiredAccuracy: LocationAccuracy.best);
//       latiout = currentPosition.latitude;
//       longout = currentPosition.longitude;

//       log("lat = ${currentPosition.latitude}\nlon= ${currentPosition.longitude}");
//       SharedPreferences sp = await SharedPreferences.getInstance();
//       sp.setDouble("latiout", latiout!.toDouble());
//       sp.setDouble("longout", longout!.toDouble());
//     }
//   }

//   getoutImage() async {
//     SharedPreferences sp = await SharedPreferences.getInstance();
//     setState(() {
//       Outimage = sp.getString("imagepathout").toString();
//       OutDate = sp.getString("outdate").toString();
//       OutTime = sp.getString("outtime")!.toString();
//       latiout = sp.getDouble("latiout")!.toDouble();
//       longout = sp.getDouble("longout")!.toDouble();
//     });
//   }

//   FinalShow() {
//     getinImage();
//     // getinLocation();
//     getoutImage();
//     // getoutLocation();
//   }
// }
