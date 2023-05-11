// import 'dart:async';
// import 'dart:convert';
// import 'layout/profile.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:dermatology1/start.dart';
// import 'package:dermatology1/update.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:dermatology1/login_screen.dart';
// import 'package:flutter/material.dart';
// import 'main.dart';
// import 'update.dart';
// import 'scan.dart';
// import 'search.dart';

// Future<Album> createAlbum(String title) async {
//   final response = await http.post(
//     Uri.parse('https://jsonplaceholder.typicode.com/albums'),
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//     body: jsonEncode(<String, String>{
//       'title': title,
//     }),
//   );

//   if (response.statusCode == 201) {
//     // If the server did return a 201 CREATED response,
//     // then parse the JSON.
//     return Album.fromJson(jsonDecode(response.body));
//   } else {
//     // If the server did not return a 201 CREATED response,
//     // then throw an exception.
//     throw Exception('Failed to create album.');
//   }
// }

// class Album {
//   final int id;
//   final String title;

//   const Album({required this.id, required this.title});

//   factory Album.fromJson(Map<String, dynamic> json) {
//     return Album(
//       id: json['id'],
//       title: json['title'],
//     );
//   }
// }

// void main() {
//   runApp(const post());
// }

// class post extends StatefulWidget {
//   const post({super.key});

//   @override
//   State<post> createState() {
//     return _MyAppState();
//   }
// }

// class _MyAppState extends State<post> {
//   final TextEditingController _controller = TextEditingController();
//   Future<Album>? _futureAlbum;

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       //title: 'Create Data Example',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: Scaffold(
//         body: Container(
//           decoration: BoxDecoration(
//             image: DecorationImage(
//               image: Image.asset("assets/back.png").image,
//               fit: BoxFit.fill,
//             ),
//           ),
//           alignment: Alignment.center,
//           padding: const EdgeInsets.all(8.0),
//           child: (_futureAlbum == null) ? buildColumn() : buildFutureBuilder(),
//         ),
//       ),
//     );
//   }

//   Column buildColumn() {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         TextField(
//           controller: _controller,
//           decoration: const InputDecoration(hintText: 'Disease Name '),
//         ),
//         MaterialButton(
//           onPressed: () {
           
//           },
//           color: Color.fromRGBO(137, 121, 113, 5),
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//           child: Text("Result", style: TextStyle(color: Colors.white)),
//         )
//       ],
//     );
//   }

//   FutureBuilder<Album> buildFutureBuilder() {
//     return FutureBuilder<Album>(
//       future: _futureAlbum,
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           return Text(snapshot.data!.title);
//         } else if (snapshot.hasError) {
//           return Text('${snapshot.error}');
//         }

//         return const CircularProgressIndicator();
//       },
//     );
//   }
// }
