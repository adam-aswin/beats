import 'package:beats/listener.dart';
import 'package:flutter/material.dart';

class Testpage extends StatefulWidget {
  const Testpage({super.key});

  @override
  State<Testpage> createState() => _TestpageState();
}

class _TestpageState extends State<Testpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: IconButton(
            onPressed: () {
              try {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Listenerpage(),
                    ));
              } catch (e) {
                print(e);
              }
            },
            icon: Icon(Icons.access_alarm),
          ),
        ),
      ),
    );
  }
}
