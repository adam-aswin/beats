import 'package:beats/listener.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Favplaylist extends StatefulWidget {
  const Favplaylist({super.key});

  @override
  State<Favplaylist> createState() => _FavplaylistState();
}

class _FavplaylistState extends State<Favplaylist> {
  final _mydata = Hive.box('mydata');
  List favourite = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fav();
  }

  void fav() {
    if (_mydata.get('key') != null) {
      favourite = _mydata.get('key');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
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
                  setState(() {
                    // value.showMiniPlayer = true;

                    // value.playAudio(file.path);

                    // value.duPos();
                    // value.name = file.path;
                    // value.currentIndex = index;
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
    );
  }
}
