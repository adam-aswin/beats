import 'package:beats/listener.dart';
import 'package:beats/provider/providerState.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';

class Favplaylist extends StatefulWidget {
  const Favplaylist({super.key});

  @override
  State<Favplaylist> createState() => _FavplaylistState();
}

class _FavplaylistState extends State<Favplaylist>
    with SingleTickerProviderStateMixin {
  final _mydata = Hive.box('mydata');
  List favourite = [];
  int currentIndex = 0;
  late AnimationController _controller1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller1 = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    fav();
  }

  void fav() {
    if (_mydata.get('key') != null) {
      favourite = _mydata.get('key');
    }
  }

  void playNext() async {
    var next = Provider.of<Providerstate>(context, listen: false);
    if (next.currentIndex < favourite.length - 1) {
      setState(() {
        next.currentIndex += 1;
        next.name = favourite[next.currentIndex];
      });
      print("==========================================================");

      print(next.name);
      await next.playAudio(favourite[next.currentIndex]);
    } else {
      print("No more songs available");
      next.currentIndex = 0;
      next.name = favourite[next.currentIndex];
      await next.playAudio(favourite[0]);
    }
  }

  void playPrev() async {
    var next = Provider.of<Providerstate>(context, listen: false);
    if (next.currentIndex < favourite.length) {
      setState(() {
        next.currentIndex -= 1;
        next.name = favourite[next.currentIndex];
      });
      print("==========================================================");
      // print(next.musicFiles[]);
      await next.playAudio(favourite[next.currentIndex]);
    } else {
      // next.currentIndex = 0;

      print("No more songs available");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Providerstate>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          title: Text(
            "Favourite Tracks",
            style: TextStyle(color: Colors.white),
          ),
          // titleTextStyle: ,
          centerTitle: true,
        ),
        extendBodyBehindAppBar: true,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.only(top: 15),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color.fromARGB(255, 0, 5, 11),
                const Color.fromARGB(255, 3, 16, 35)
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: favourite.length,
                  itemBuilder: (context, index) {
                    String fav = favourite[index];
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
                          Navigator.pushNamed(
                            context,
                            "/music",
                          );
                          setState(() {
                            value.showMiniPlayer = true;

                            value.playAudio(fav);

                            value.duPos();
                            value.name = fav;
                            value.currentIndex = index;
                            // currentIndex = index;
                            // print(
                            //     "+++++++++++++++++++++++++++++++++++++++++++++++");
                            // print(value.currentIndex);
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
                          fav.split('/').last.split('-').first.trim(),
                          style: TextStyle(
                            color: Colors.white,
                            // fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        subtitle: Text(
                          fav
                              .split('/')
                              .last
                              .split('-')
                              .last
                              .substring(
                                0,
                                fav.split('/').last.split('-').last.length - 4,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                                  ? value.audioPlayer.pause()
                                                  : value.audioPlayer.play();
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
    );
  }
}
