// import 'package:beats/homepage.dart';
import 'package:beats/beats.dart';
import 'package:beats/listener.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Homepage(),
      routes: {
        "/music": (context) => Listenerpage(),
      },
    ),
  );
}
