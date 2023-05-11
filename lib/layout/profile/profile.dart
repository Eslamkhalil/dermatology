import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dermatology1/services/auth.dart';
import 'package:dermatology1/layout/profile/EditProfilePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/user.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  UserModel? userModel;

  void getUser() async {
    final _auth = AuthServices();
    var user = FirebaseAuth.instance.currentUser;
    var model =
        await _auth.getUser(user!.uid); // Execute asynchronous work first
    setState(() {
      userModel = model; // Update the state synchronously inside setState()
    });
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: Image.asset("assets/back.png").image,
              fit: BoxFit.fill,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      height: 150,
                      width: 50,
                    ),

                    const SizedBox(
                      width: 70,
                    ),
                    //  Image(
                    //  alignment: Alignment.topCenter,
                    //height: 150,
                    //width: 200, //Napta_img
                    //image: Image.asset("assets/log.png").image,
                    //),
                    //1
                  ],
                ),
                SizedBox(
                  height: 400,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        height: 300,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color.fromARGB(255, 42, 49, 43),
                              width: 2.0),
                          borderRadius: BorderRadius.circular(40), //Card
                          color: Colors.white.withOpacity(0.5),
                        ),
                      ),
                      Container(
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 180,
                              width: 180,
                              child:
                                  Stack(alignment: Alignment.center, children: [
                                //photo stack
                                const CircleAvatar(
                                  radius: 80,
                                  backgroundImage: AssetImage(
                                      "assets/admin.png"), //avtar if my img
                                ),

                                Container(
                                  width: 170,
                                  height: 170,
                                  alignment: Alignment.bottomRight,
                                  child: IconButton(
                                    icon: const Icon(Icons.camera_alt_rounded),
                                    iconSize: 40,
                                    onPressed: () {},
                                  ),
                                ),
                              ]),
                            ),
                            Text(
                              '${userModel?.fname ?? ''} ${userModel?.lname ?? ''}',
                              style: const TextStyle(
                                  color: Color.fromRGBO(137, 121, 113, 5),
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.none),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 50.0,
                                ),
                                const Text(
                                  "E-mail",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w600,
                                      decoration: TextDecoration.none),
                                ),
                                const SizedBox(
                                  width: 25.0,
                                ),
                                SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: const Image(
                                    image: AssetImage("assets/email.png"),
                                  ),
                                ),
                                const SizedBox(
                                  width: 15.0,
                                ),
                                Text(
                                  '${userModel?.email ?? ''}',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12.0,
                                      decoration: TextDecoration.none),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 52.0,
                                ),
                                const Text(
                                  "Phone",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12.0,
                                      decoration: TextDecoration.none),
                                ),
                                const SizedBox(
                                  width: 25.0,
                                ),
                                SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: const Image(
                                    image: AssetImage("assets/phone.png"),
                                  ),
                                ),
                                const SizedBox(
                                  width: 15.0,
                                ),
                                Text(
                                  userModel?.phone ?? '',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w600,
                                      decoration: TextDecoration.none),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 40.0,
                                ),
                                const Text(
                                  "Nationality",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w600,
                                      decoration: TextDecoration.none),
                                ),
                                const SizedBox(
                                  width: 17.0,
                                ),
                                SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: const Image(
                                    image: AssetImage("assets/nat.png"),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20.0,
                                ),
                                Container(
                                  alignment: AlignmentDirectional.center,
                                  child: Text(
                                    "${userModel?.location}",
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w600,
                                        decoration: TextDecoration.none),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            SizedBox(
                                width: 250,
                                height: 40,
                                child: MaterialButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => EditProfilePage(
                                                user: userModel!,
                                              )),
                                    );
                                  },
                                  color: const Color.fromRGBO(137, 121, 113, 5),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: const Text("update",
                                      style: TextStyle(color: Colors.white)),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
