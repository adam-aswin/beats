import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'dart:math' as math;

import 'package:lottie/lottie.dart';

class Listenerpage extends StatefulWidget {
  const Listenerpage({super.key});

  @override
  State<Listenerpage> createState() => _ListenerpageState();
}

class _ListenerpageState extends State<Listenerpage>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _controller1;
  late Animation<double> _animation;
  bool isIcon = false;
  bool isDisc = false;
  bool isfav = false;
  bool isRepeat = false;
  bool isShuffle = false;
  final _audioPlayer = AudioPlayer();
  String? path;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    _controller1 = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _animation = Tween<double>(
      begin: 0.0,
      end: math.pi * 2,
    ).animate(_controller);
    _controller.repeat();
    print("====================");
    Future.delayed(
      Duration(
        milliseconds: 10,
      ),
      () {
        playAudio(path!);
      },
    );
    print("====================");
  }

  Future<void> playAudio(String filePath) async {
    try {
      await _audioPlayer.setFilePath(filePath);
      await _audioPlayer.play();
    } catch (e) {
      print("Error occured :$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    path = ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: const Color.fromARGB(239, 255, 255, 255),
        ),
        title: Text(
          "Now Playing",
          style: TextStyle(
            color: Colors.white54,
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),
        // leading: IconButton(
        //   onPressed: () {},
        //   icon: Icon(
        //     Icons.keyboard_arrow_down_rounded,
        //     size: 35,
        //   ),
        // ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.more_horiz,
            ),
          ),
        ],
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(top: 80),
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [
            const Color.fromARGB(255, 1, 7, 14),
            const Color.fromARGB(255, 4, 24, 54)
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        )),
        child: Column(
          children: [
            Container(
              height: 430,
              width: MediaQuery.of(context).size.width,
              // padding: EdgeInsets.only(top: 50),
              // color: Colors.red,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: AnimatedBuilder(
                      animation: _animation,
                      builder: (context, child) {
                        return Transform.rotate(
                          angle: isIcon ? 0 : _animation.value,
                          child: child,
                        );
                      },
                      child: Container(
                        height: 250,
                        width: 250,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          // color: const Color.fromARGB(255, 24, 24, 24),
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            "./images/Music-Streaming-Wars.webp",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: isIcon
                        ? null
                        : Lottie.asset(
                            "./lib/Lottie/Animation - 1733311288281.json",
                            fit: BoxFit.cover,
                            frameRate: FrameRate(120),
                            height: double.infinity,
                            width: MediaQuery.of(context).size.width,
                          ),
                  )
                ],
              ),
            ),
            Text(
              path!.split('/').last.split('-').first,
              style: TextStyle(
                color: const Color.fromARGB(239, 255, 255, 255),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              path!.split('/').last.split('-').last.substring(
                    0,
                    path!.split('/').last.split('-').last.length - 4,
                  ),
              style: TextStyle(
                color: Colors.white54,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 45,
            ),
            Container(
              height: 5,
              width: MediaQuery.of(context).size.width * .85,
              color: Colors.white12,
            ),
            Container(
              // height: 5,
              width: MediaQuery.of(context).size.width * .85,
              // color: Colors.white12,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "0:00",
                    style: TextStyle(
                      color: const Color.fromARGB(239, 255, 255, 255),
                    ),
                  ),
                  Text(
                    "0:00",
                    style: TextStyle(
                      color: const Color.fromARGB(239, 255, 255, 255),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              width: MediaQuery.of(context).size.width * .8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isShuffle = !isShuffle;
                      });
                    },
                    icon: Icon(
                      Icons.shuffle,
                      size: 25,
                      color: isShuffle
                          ? Colors.green
                          : const Color.fromARGB(234, 255, 255, 255),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isfav = !isfav;
                      });
                    },
                    icon: Icon(
                      isfav ? Icons.favorite : Icons.favorite_border,
                      size: 27,
                      color: isfav
                          ? Colors.red[900]
                          : const Color.fromARGB(239, 255, 255, 255),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isRepeat = !isRepeat;
                      });
                    },
                    icon: Icon(
                      Icons.repeat,
                      size: 25,
                      color: isRepeat
                          ? Colors.green
                          : const Color.fromARGB(234, 255, 255, 255),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width * .85,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.skip_previous_rounded,
                      size: 35,
                      color: const Color.fromARGB(234, 255, 255, 255),
                    ),
                  ),
                  IconButton(
                    style: IconButton.styleFrom(
                      backgroundColor: const Color.fromARGB(239, 255, 255, 255),
                      padding: EdgeInsets.all(
                        15,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        isIcon = !isIcon;

                        isIcon
                            ? _controller1.forward()
                            : _controller1.reverse();
                        isIcon ? _audioPlayer.pause() : _audioPlayer.play();
                      });
                    },
                    icon: AnimatedIcon(
                      icon: AnimatedIcons.pause_play,
                      color: Colors.black,
                      size: 30,
                      progress: _controller1,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.skip_next_rounded,
                      size: 35,
                      color: const Color.fromARGB(234, 255, 255, 255),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose of the animation controller when the widget is disposed
    _controller.dispose();
    super.dispose();
  }
}
