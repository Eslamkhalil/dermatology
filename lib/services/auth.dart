import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../layout/home_screen.dart';
import '../login_screen.dart';
import '../model/user.dart';
import '../utils/toast.dart';
import '../utils/progressIndicatorDialog.dart';

class AuthServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createUser({
    required BuildContext context,
    required String email,
    required String password,
    required String fname,
    required String lname,
    required String phone,
  }) async {
    try {
      if (password.toString().length < 6) {
        showToast(
            message: 'يجب أن تكون كلمة المرور إكثر من 6 ارقام',
            state: ToastStates.warning);
        return;
      }
      ProgressIndicatorDialog().show(context);
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await _firestore.collection("Users").doc(userCredential.user!.uid).set({
        "fname": fname,
        "lname": lname,
        "email": email,
        "password": password,
        "phone": phone,
      });
      Navigator.of(context).pop();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
      //  navigationPushAndRemoveUntil(context,HomeScreen(isAdmin: isAdmin,));
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();
      if (e.code == 'weak-password') {
        AwesomeDialog(
                context: context,
                title: "Error",
                body: const Text("Password is to weak"))
            .show();
      } else if (e.code == 'email-already-in-use') {
        Navigator.of(context).pop();
        AwesomeDialog(
                context: context,
                title: "Error",
                body: const Text("The account already exists for that email"))
            .show();
      }
    } catch (e) {
      Navigator.of(context).pop();
      log('$e');
    }
  }

  Future<void> login(
    BuildContext context,
    String email,
    password,
  ) async {
    try {
      if (password.toString().length < 6) {
        showToast(
            message: 'يجب أن تكون كلمة المرور إكثر من 6 ارقام',
            state: ToastStates.warning);
        return;
      }

      ProgressIndicatorDialog().show(context);
      FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        Navigator.of(context).pop();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      });
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();
      if (e.code == 'user-not-found') {
        AwesomeDialog(
                context: context,
                title: "Error",
                body: const Text("No user found for that email"))
            .show();
      } else if (e.code == 'wrong-password') {
        Navigator.of(context).pop();
        AwesomeDialog(
                context: context,
                title: "Error",
                body: const Text("Wrong password provided for that user"))
            .show();
      }
    } catch (e) {
      Navigator.of(context).pop();
      log('$e');
    }
  }

  Future<UserModel> getUser(String uid) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection("Users").doc(uid).get();

      return UserModel.fromSnapShot(doc);
    } catch (e) {
      rethrow;
    }
  }
}
