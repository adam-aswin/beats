// class Animatedprovider with tick{}
import 'package:flutter/material.dart';

class Animatedprovider extends StatefulWidget {
  const Animatedprovider({super.key});

  @override
  State<Animatedprovider> createState() => _AnimatedproviderState();
}

class _AnimatedproviderState extends State<Animatedprovider> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
      ),
    );
  }
}
