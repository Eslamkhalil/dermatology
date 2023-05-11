import 'dart:async';

import 'package:flutter/material.dart';
import 'login_screen.dart';

class Start extends StatefulWidget {
  const Start({super.key});

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  Timer? _timer;

  _goNext() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    // animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  void _startDelay() => _timer = Timer(const Duration(seconds: 3), _goNext);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Container(
          decoration: const BoxDecoration(),
          width: 2000,
          child: Stack(
            children: <Widget>[
              Image.asset(
                'assets/start.png',
                width: 10000,
                height: 10000,
                fit: BoxFit.cover,
              ),
              // Positioned(
              //   bottom: 15,
              //   right: 15,
              //   child: OutlinedButton(
              //     child: const Text(
              //       'Login',
              //       style: TextStyle(
              //         color: Colors.white,
              //       ),
              //     ),
              //     onPressed: () {
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(builder: (context) => second()),
              //       );
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
