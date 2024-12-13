import 'package:beats/Fav.dart';
import 'package:beats/beats.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Bottomnavigation extends StatefulWidget {
  const Bottomnavigation({super.key});

  @override
  State<Bottomnavigation> createState() => _BottomnavigationState();
}

class _BottomnavigationState extends State<Bottomnavigation> {
  int page = 0;
  List<Widget> screens = [Homepage(), FavPage()];
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, value, child) => Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          onTap: (value) {
            setState(() {
              page = value;
            });
          },
          letIndexChange: (value) => true,
          backgroundColor: const Color.fromARGB(255, 5, 29, 66),
          color: const Color.fromARGB(255, 4, 21, 47),
          height: 55,
          items: [
            Icon(
              Icons.home,
              color: page == 0 ? Colors.white : Colors.white38,
            ),
            Icon(
              Icons.bar_chart_rounded,
              color: page == 1 ? Colors.white : Colors.white38,
            ),
          ],
        ),
        body: screens[page],
      ),
    );
  }
}
