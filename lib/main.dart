
import 'package:timekeeper/homepage.dart';
import 'package:timekeeper/timer.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final CountDownTimer timer = CountDownTimer();

  final double defaultPadding = 5.0;

  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "TimeU",
      theme: ThemeData(
          primarySwatch: Colors.purple ),
      home: HomePage(),
    );
  }
}
