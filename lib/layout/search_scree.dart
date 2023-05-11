import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  CollectionReference diseaseCollection =
      FirebaseFirestore.instance.collection("disease");
  final TextEditingController _controller = TextEditingController();
  List<DocumentSnapshot> allDiseases = [];
  List<DocumentSnapshot> searchResults = [];

  @override
  void initState() {
    super.initState();
    fetchDiseases();
  }

  Future<void> fetchDiseases() async {
    final snapshot = await diseaseCollection.get();
    setState(() {
      allDiseases = snapshot.docs;
      searchResults = snapshot.docs;
    });
  }

  void _onSearchTextChanged(String text) {
    setState(() {
      searchResults = allDiseases.where((e) {
        final diseases = e['diseaseName'].toString().toLowerCase();
        return diseases.contains(text.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset("assets/back.png"),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 60.0),
              TextField(
                onChanged: (value) {
                  _onSearchTextChanged(value);
                },
                controller: _controller,
                decoration:
                    const InputDecoration(hintText: 'Search By Disease Name'),
              ),
              const SizedBox(height: 16.0),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: searchResults.length,
                  itemBuilder: (BuildContext context, int index) {
                    final diseaseData = searchResults[index];
                    return DiseaseCard(
                      diseaseName: diseaseData['diseaseName'],
                      cause: diseaseData['cause'],
                      contagiousDisease: diseaseData['contagious_disease'],
                      forbiddenFood: diseaseData['forbidden_food'],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class DiseaseCard extends StatelessWidget {
  final String? diseaseName;
  final String? cause;
  final String? contagiousDisease;
  final String? forbiddenFood;

  DiseaseCard({
    required this.diseaseName,
    required this.cause,
    required this.contagiousDisease,
    required this.forbiddenFood,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(color: Colors.grey.shade400, width: 1.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  'Disease Name:',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    diseaseName ?? '',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Row(
              children: <Widget>[
                Text(
                  'Cause:',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    cause ?? '',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Row(
              children: <Widget>[
                Text(
                  'Contagious Disease:',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    contagiousDisease ?? '',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Row(
              children: <Widget>[
                Text(
                  'Forbidden Food:',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    forbiddenFood ?? '',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
