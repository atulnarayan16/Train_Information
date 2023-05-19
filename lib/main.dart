import 'dart:async';
import 'package:trainstatus/trainquery.dart';

import 'trainquery.dart';
import 'package:flutter/material.dart';
import 'traininfo.dart';
import 'main.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 6),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const TrainStatus())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(children: const <Widget>[
          Image(image: AssetImage('assets/welcome.gif')),
          Text('Made by Atul Narayan',
              style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic))
        ]),
      ),
    );
  }
}
