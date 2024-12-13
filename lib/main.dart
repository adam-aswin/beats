// import 'package:beats/homepage.dart';
import 'package:beats/beats.dart';
import 'package:beats/bottomNavigation.dart';
import 'package:beats/listener.dart';
import 'package:beats/provider/providerState.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => Providerstate(),
    child: MaterialApp(
      home: Bottomnavigation(),
      routes: {
        "/music": (context) => Listenerpage(),
      },
    ),
  ));
}
