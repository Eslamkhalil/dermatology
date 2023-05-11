// import 'package:dermatology1/start.dart';
// import 'package:dermatology1/update.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:dermatology1/login_screen.dart';
// import 'package:flutter/material.dart';
// import 'main.dart';
// import 'layout/profile.dart';

// class scan extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 100.0,
//       width: MediaQuery.of(context).size.width,
//       margin: EdgeInsets.symmetric(
//         horizontal: 20,
//         vertical: 20,
//       ),
//       child: Column(
//         children: <Widget>[
//           SizedBox(
//             height: 20,
//           ),
//           Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
//             OutlinedButton.icon(
//               icon: Icon(Icons.camera),
//               onPressed: () {
//                 // takePhoto(ImageSource.camera);
//               },
//               label: Text("Camera"),
//             ),
//             OutlinedButton.icon(
//               icon: Icon(Icons.image),
//               onPressed: () {
//                 //  takePhoto(ImageSource.gallery);
//               },
//               label: Text("Gallery"),
//             ),
//           ])
//         ],
//       ),
//     );
//   }

//   void takePhoto(ImageSource source) async {
//     var _picker;
//     final pickedFile = await _picker.getImage(
//       source: source,
//     );
//     //setState(() {
//     //_imageFile = pickedFile;
//     // }
//     // );
//   }
// }

// mixin ImageSource {}

// mixin CameraDescription {}
