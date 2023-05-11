import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: Image.asset("assets/back.png").image,
          fit: BoxFit.fill,
        ),
      ),
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(
        vertical: 80,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _controller,
              decoration: const InputDecoration(hintText: 'Disease Name '),
            ),
            MaterialButton(
              onPressed: () {},
              color: Color.fromRGBO(137, 121, 113, 5),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: const Text("Result", style: TextStyle(color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }
}
