// import 'package:flutter/material.dart';

// class check extends StatefulWidget {
//   const check({super.key});

//   @override
//   State<check> createState() => _checkState();
// }

// class _checkState extends State<check> {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//       body: Column(
//         children: [
//           Container(
//             width: MediaQuery.of(context).size.width,
//             margin: EdgeInsets.all(8.0),
//             decoration: BoxDecoration(
//                 color: Color.fromARGB(255, 145, 249, 148),
//                 border: Border.all(
//                   width: 1.0,
//                 ),
//                 borderRadius: BorderRadius.circular(30)),
//             child: Row(
//               children: [
//                  Inimage != null ?Container(width:50,height: 50,child:  Image.file(fit: BoxFit.fill, File(Inimage.toString()))): Text("no Image found"),


//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Row(
//                       children: [
//                         Text("Date:- 31/31/31"),
//                         InTime != null
//                 ? Text("IN Time :- ${InTime}")
//                 : Text("No Time Found"),
                       
//                       ],
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         longin != null
//                 ? Text("long = ${longin} \n lat = ${latiin}")
//                 : Text("no location found"),
//                       ],
//                     )
//                   ],
//                 )
//               ],
//             ),
//           ),


//           Container(
//             width: MediaQuery.of(context).size.width,
//             margin: EdgeInsets.all(8.0),
//             decoration: BoxDecoration(
//                 color: Color.fromARGB(255, 145, 249, 148),
//                 border: Border.all(
//                   width: 1.0,
//                 ),
//                 borderRadius: BorderRadius.circular(30)),
//             child: Row(
//               children: [
//  Outimage != null? Container(width: 50,height: 50,child:Image.file(fit: BoxFit.fill, File(Outimage.toString())))
//                 : Text("no data found"),

//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Row(
//                       children: [
//                         Text("Date:- 31/31/31"),
//                         OutTime != null
//                 ? Text("IN Time :- ${OutTime}")
//                 : Text("No Time Found"),
                       
//                       ],
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         longout != null
//                 ? Text("long = ${longout} \n lat = ${latiout}")
//                 : Text("no location found"),
//                       ],
//                     )
//                   ],
//                 )
//               ],
//             ),
//           )
//        ,ElevatedButton(
//                     onPressed: () {
//                       pickImageFormCamerain();
//                     },
//                     child: Text("In")),
//                 ElevatedButton(
//                     onPressed: isUserIn == false
//                         ? null
//                         : () {
//                             pickImageFormCameraout();
//                           },
//                     child: Text("OUT"))
//               ],
//             ),
//             ElevatedButton(
//                 onPressed: () {
//                   setState(() {
//                     FinalShow();
//                   });
//                 },
//                 child: Text("show ")), 
  
//       ),
//     );
//   }
// }
