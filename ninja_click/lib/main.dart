import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: const HomeScreen()));
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int buttonShows = 5;
  DateTime? startTime;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    int width = (screenWidth - screenWidth / 10).toInt();
    int height = (screenHeight - screenHeight / 10 - 100).toInt();

    final random = Random();

    showAlertDialog(BuildContext context, int seconds) {
      int sec = (seconds / 1000).toInt();
      int mill = seconds - sec;

      Widget okButton = TextButton(
        child: const Text(
          "Restart",
          style: TextStyle(color: Colors.purpleAccent),
        ),
        onPressed: () {
          Navigator.pop(context);
          buttonShows = 5;
          startTime = DateTime.now().toUtc();
          setState(() {});
        },
      );

      AlertDialog alert = AlertDialog(
        backgroundColor: Colors.grey[800],
        title: const Text(
          'Mission Accomplished!',
          style: TextStyle(color: Colors.white),
        ),
        content: Text(
          'You completed the mission in $sec.$mill seconds!',
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          okButton,
        ],
      );

      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

    if (buttonShows == 5) startTime = DateTime.now().toUtc();

    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        shadowColor: Colors.purple,
        elevation: 15.0,
        backgroundColor: Colors.black,
        title: const Text('Ninja Click'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned(
            left: random.nextInt((width).toInt()).toDouble(),
            top: random.nextInt((height).toInt()).toDouble(),
            child: Container(
              margin: const EdgeInsets.all(0.0),
              height: width / 10,
              width: width / 10,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 10,
                    blurRadius: 10,
                    offset: const Offset(2, 2),
                  ),
                ],
              ),
              child: GestureDetector(
                onTap: () async {
                  buttonShows--;
                  if (buttonShows == 0) {
                    DateTime endTime = DateTime.now().toUtc();
                    int timeTaken =
                        endTime.difference(startTime!).inMilliseconds;
                    showAlertDialog(context, timeTaken);
                  } else {
                    setState(() {});
                  }
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    'images/ninja.png',
                    height: width / 10,
                    width: width / 10,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
