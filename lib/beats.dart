import 'dart:io';

import 'package:beats/listener.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final _audioPlayer = AudioPlayer();

  void playAudio() async {
    try {
      _audioPlayer.setLoopMode(LoopMode.one);
      final result =
          await FilePicker.platform.pickFiles(allowedExtensions: ['mp3']);
      if (result != null) {
        final file = File(result.files.single.path!);
        _audioPlayer.setUrl(file.path);
      }
      // await _audioPlayer.setFilePath()
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "User name",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
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
      body: Container(
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
        child: Column(
          children: [
            Container(
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
              child: Expanded(
                child: TextField(
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
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.only(left: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Playlist",
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
            SizedBox(
              height: 10,
            ),
            Container(
              height: 200,
              child: Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(10),
                  scrollDirection: Axis.horizontal,
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(right: 10),
                      padding: EdgeInsets.all(10),
                      width: 140,
                      height: 150,
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 110,
                            decoration: BoxDecoration(
                              color: Colors.grey[900],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                "./images/fav.webp",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Favourite Tracks",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
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
            Container(
              child: Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(10),
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 72,
                      width: MediaQuery.of(context).size.width * .9,
                      margin: EdgeInsets.only(left: 5, right: 5, bottom: 10),
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
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => Listenerpage(),
                          //     ));
                          playAudio();
                        },
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
                          "Music Name",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          "Artist",
                          style: TextStyle(color: Colors.white54),
                        ),
                        trailing: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
