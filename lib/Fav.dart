import 'package:beats/provider/providerState.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';

class FavPage extends StatefulWidget {
  const FavPage({super.key});

  @override
  State<FavPage> createState() => _FavPageState();
}

class _FavPageState extends State<FavPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller1 = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
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

  @override
  Widget build(BuildContext context) {
    return Consumer<Providerstate>(
      builder: (context, value, child) => Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            "Playlist",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
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
                // height: 200,
                child: Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 2 / 2.2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 10,
                      crossAxisCount: 2,
                    ),
                    padding: EdgeInsets.all(10),
                    // scrollDirection: Axis.horizontal,
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, "/favplay");
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 10),
                          padding: EdgeInsets.all(10),
                          width: 130,
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color.fromARGB(255, 3, 18, 40),
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
