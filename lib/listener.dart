import 'dart:async';

import 'package:beats/provider/providerState.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'dart:math' as math;

import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

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

  String? path;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _audioPlayer.playerStateStream.listen((state) {
    //   if (state.processingState == ProcessingState.completed) {
    //     setState(() {
    //       isIcon = true;
    //       // _controller1.reverse();
    //       isRestart = true;
    //     });
    //   }
    // });
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
        // playAudio(path!);
      },
    );
    print("====================");
    // data();
  }

  void playNext() async {
    var next = Provider.of<Providerstate>(context, listen: false);
    if (next.currentIndex < next.musicFiles.length) {
      setState(() {
        next.currentIndex += 1;
      });
      print("==========================================================");
      // print(next.musicFiles[]);
      await next.playAudio(next.musicFiles[next.currentIndex].path);
    } else {
      print("No more songs available");
    }
  }

  void playPrev() async {
    var next = Provider.of<Providerstate>(context, listen: false);
    if (next.currentIndex < next.musicFiles.length) {
      setState(() {
        next.currentIndex -= 1;
      });
      print("==========================================================");
      // print(next.musicFiles[]);
      await next.playAudio(next.musicFiles[next.currentIndex].path);
    } else {
      print("No more songs available");
    }
  }

  // void data() {
  //   var data = Provider.of<Providerstate>(context, listen: false);
  //   data.audioPlayer.playerStateStream.listen((state) {
  //     if (state.processingState == ProcessingState.completed) {
  //       playNext();
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    path = ModalRoute.of(context)?.settings.arguments as String;
    return Consumer<Providerstate>(
      builder: (context, value, child) => Scaffold(
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
                            angle: value.isIcon ? 0 : _animation.value,
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
                      child: value.isIcon
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
                height: 40,
              ),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  overlayShape: SliderComponentShape.noOverlay,
                ),
                child: Container(
                  // height: 5,
                  width: MediaQuery.of(context).size.width * .9,
                  // color: Colors.white12,
                  child: Slider(
                    activeColor: const Color.fromARGB(255, 10, 58, 131),
                    inactiveColor: Colors.white12,
                    min: 0,
                    max: value.duration.inSeconds.toDouble(),
                    value: value.position.inSeconds.toDouble().clamp(
                          0.0,
                          value.duration.inSeconds.toDouble(),
                        ),
                    onChanged: value.seek,
                  ),
                ),
              ),
              Container(
                // height: 5,
                width: MediaQuery.of(context).size.width * .85,
                // color: Colors.white12,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      value.formatDuration(value.position),
                      // "",
                      style: TextStyle(
                        color: const Color.fromARGB(239, 255, 255, 255),
                      ),
                    ),
                    Text(
                      value.formatDuration(value.duration - value.position),
                      // "",
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
                          value.isShuffle = !value.isShuffle;
                        });
                      },
                      icon: Icon(
                        Icons.shuffle,
                        size: 25,
                        color: value.isShuffle
                            ? Colors.green
                            : const Color.fromARGB(234, 255, 255, 255),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          value.isfav = !value.isfav;
                        });
                      },
                      icon: Icon(
                        value.isfav ? Icons.favorite : Icons.favorite_border,
                        size: 27,
                        color: value.isfav
                            ? Colors.red[900]
                            : const Color.fromARGB(239, 255, 255, 255),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          value.isRepeat = !value.isRepeat;
                          value.isRepeat
                              ? value.audioPlayer.setLoopMode(LoopMode.one)
                              : value.audioPlayer.setLoopMode(LoopMode.off);
                        });
                      },
                      icon: Icon(
                        Icons.repeat,
                        size: 25,
                        color: value.isRepeat
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
                      onPressed: playPrev,
                      icon: Icon(
                        Icons.skip_previous_rounded,
                        size: 35,
                        color: const Color.fromARGB(234, 255, 255, 255),
                      ),
                    ),
                    IconButton(
                      style: IconButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(239, 255, 255, 255),
                        padding: EdgeInsets.all(
                          15,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          value.isIcon = !value.isIcon;

                          value.isIcon
                              ? _controller1.forward()
                              : _controller1.reverse();
                          value.isIcon
                              ? value.audioPlayer.pause()
                              : value.audioPlayer.play();
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
                      onPressed: playNext,
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
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    // _controller1.dispose();
    // _audioPlayer.dispose();
    super.dispose();
  }
}
