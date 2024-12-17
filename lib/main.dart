// import 'package:beats/homepage.dart';
import 'package:beats/beats.dart';
import 'package:beats/bottomNavigation.dart';
import 'package:beats/favPlaylist.dart';
import 'package:beats/listener.dart';
import 'package:beats/provider/providerState.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  await Hive.initFlutter();

  var data = await Hive.openBox('mydata');
  runApp(ChangeNotifierProvider(
    create: (context) => Providerstate(),
    child: MaterialApp(
      home: Bottomnavigation(),
      routes: {
        "/music": (context) => Listenerpage(),
        "/favplay": (context) => Favplaylist(),
      },
    ),
  ));
}
