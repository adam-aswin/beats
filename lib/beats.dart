import 'dart:io';

import 'package:beats/listener.dart';
import 'package:beats/provider/providerState.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:just_audio/just_audio.dart';
import 'package:marquee/marquee.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller1;
  var files;

  int currentIndex = 0;
  bool? showMiniPlayer;
  final _mydata = Hive.box('mydata');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // fetchMusic();
    _controller1 = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    data();
    // controller();
  }

  void playNext() async {
    var next = Provider.of<Providerstate>(context, listen: false);
    if (next.currentIndex < next.musicFiles.length - 1) {
      setState(() {
        next.currentIndex += 1;
        next.name = next.musicFiles[next.currentIndex].path;
      });
      print("==========================================================");

      print(next.name);
      await next.playAudio(next.musicFiles[next.currentIndex].path);
    } else {
      print("No more songs available");
      next.currentIndex = 0;
      next.name = next.musicFiles[next.currentIndex].path;
      await next.playAudio(next.musicFiles[0].path);
    }
  }

  void playPrev() async {
    var next = Provider.of<Providerstate>(context, listen: false);
    if (next.currentIndex < next.musicFiles.length) {
      setState(() {
        next.currentIndex -= 1;
        next.name = next.musicFiles[next.currentIndex].path;
      });
      print("==========================================================");
      // print(next.musicFiles[]);
      await next.playAudio(next.musicFiles[next.currentIndex].path);
    } else {
      // next.currentIndex = 0;

      print("No more songs available");
    }
  }

  void data() {
    var data = Provider.of<Providerstate>(context, listen: false);
    data.fetchMusic();
    data.audioPlayer.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        playNext();
      }
    });
    data.isfav = false;
  }

  void controller() {
    var data = Provider.of<Providerstate>(context, listen: false);
    if (data.isIcon == true) {
      setState(() {
        _controller1.forward();
      });
    }
  }

  Future<void> refreshPage() async {
    await Future.delayed(Duration(seconds: 1));
    data();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Providerstate>(
      builder: (context, value, child) => Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            "Beats",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notifications_none,
                color: Colors.white,
              ),
            )
          ],
        ),
        body: RefreshIndicator(
          onRefresh: refreshPage,
          backgroundColor: Colors.transparent,
          color: Colors.blue,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(top: 115),
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [
                const Color.fromARGB(255, 0, 5, 11),
                const Color.fromARGB(255, 3, 16, 35)
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            )),
            child: Expanded(
              child: Column(
                children: [
                  Expanded(
                    flex: 0,
                    child: Container(
                      width: MediaQuery.of(context).size.width * .9,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(255, 3, 17, 37),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 5,
                            spreadRadius: 0,
                            offset: Offset(5, 5),
                            color: Colors.black54,
                          ),
                        ],
                      ),
                      child: TextField(
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        cursorColor: Colors.white38,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          hintText: "Search Songs",
                          hintStyle: TextStyle(
                            color: Colors.white38,
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.white38,
                          ),
                        ),
                        onTap: () {},
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    flex: 0,
                    child: Container(
                      padding: EdgeInsets.only(left: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "All songs",
                            style: TextStyle(
                              color: Colors.white,
                              decoration: TextDecoration.underline,
                              // decorationColor: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      child: ListView.builder(
                        padding: EdgeInsets.all(10),
                        itemCount: value.musicFiles.length,
                        itemBuilder: (context, index) {
                          final file = value.musicFiles[index];
                          // print(_musicFiles);
                          return Container(
                            height: 72,
                            width: MediaQuery.of(context).size.width * .9,
                            margin:
                                EdgeInsets.only(left: 5, right: 5, bottom: 10),
                            // padding: EdgeInsets.only(top: 6, bottom: 6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromARGB(255, 3, 17, 37),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 5,
                                  spreadRadius: 0,
                                  offset: Offset(5, 5),
                                  color: Colors.black54,
                                ),
                              ],
                            ),
                            child: ListTile(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  "/music",
                                  arguments: file.path,
                                );
                                setState(() {
                                  value.showMiniPlayer = true;

                                  value.playAudio(file.path);

                                  value.duPos();
                                  value.name = file.path;
                                  value.currentIndex = index;
                                  currentIndex = index;
                                });
                              },
                              onLongPress: () {},
                              leading: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: Colors.grey[900],
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Image.asset(
                                    "./images/Music-Streaming-Wars.webp",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              title: Text(
                                file.path
                                    .split('/')
                                    .last
                                    .split('-')
                                    .first
                                    .trim(),
                                style: TextStyle(
                                  color: Colors.white,
                                  // fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              subtitle: Text(
                                file.path
                                    .split('/')
                                    .last
                                    .split('-')
                                    .last
                                    .substring(
                                      0,
                                      file.path
                                              .split('/')
                                              .last
                                              .split('-')
                                              .last
                                              .length -
                                          4,
                                    )
                                    .trim(),
                                style: TextStyle(color: Colors.white54),
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  // playNext();
                                },
                                icon: Icon(
                                  Icons.more_vert,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  value.showMiniPlayer
                      ? Expanded(
                          flex: 0,
                          child: Container(
                            height: 60,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(15),
                              ),
                              color: const Color.fromARGB(255, 5, 29, 66),
                            ),
                            child: ListTile(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  "/music",
                                );
                              },
                              trailing: IconButton(
                                onPressed: () {
                                  setState(() {
                                    value.showMiniPlayer = false;
                                    value.audioPlayer.pause();
                                  });
                                },
                                icon: Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              leading: Container(
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                  color: Colors.grey[900],
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Image.asset(
                                    "./images/Music-Streaming-Wars.webp",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 93,
                                    height: 30,
                                    child: Marquee(
                                      text:
                                          "${value.name.split('/').last.split('-').first.trim()}(${value.name.split('/').last.split('-').last.substring(
                                                0,
                                                value.name
                                                        .split('/')
                                                        .last
                                                        .split('-')
                                                        .last
                                                        .length -
                                                    4,
                                              ).trim()})",
                                      style: TextStyle(color: Colors.white),
                                      blankSpace: 20,
                                      scrollAxis: Axis.horizontal,
                                      velocity: 50,
                                      // pauseAfterRound: Duration(seconds: 1),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 0,
                                    child: Container(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 0,
                                            child: IconButton(
                                              onPressed: playPrev,
                                              icon: Icon(
                                                Icons.skip_previous_rounded,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 0,
                                            child: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  value.isIcon = !value.isIcon;

                                                  value.isIcon
                                                      ? _controller1.forward()
                                                      : _controller1.reverse();
                                                  value.isIcon
                                                      ? value.audioPlayer
                                                          .pause()
                                                      : value.audioPlayer
                                                          .play();
                                                });
                                              },
                                              icon: AnimatedIcon(
                                                icon: AnimatedIcons.pause_play,
                                                color: Colors.white,
                                                // size: 30,
                                                progress: _controller1,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 0,
                                            child: IconButton(
                                              onPressed: playNext,
                                              icon: Icon(
                                                Icons.skip_next_rounded,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : Expanded(flex: 0, child: Container()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
