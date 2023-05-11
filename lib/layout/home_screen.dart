import 'package:dermatology1/layout/pick_image.dart';
import 'package:dermatology1/layout/post_screen.dart';
import 'package:dermatology1/layout/search_scree.dart';
import 'package:flutter/material.dart';

import 'profile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;

  List<Widget> screens = [
    PostScreen(),
    PickImageScreen(),
    SearchScreen(),
    Profile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: screens[index]),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: index,
          onTap: (value) {
            setState(() {
              index = value;
            });
          },
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'AddPost'),
            BottomNavigationBarItem(
                icon: Icon(Icons.image), label: 'PickImage'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_2_outlined), label: 'Profile'),
          ]),
    );
  }
}
