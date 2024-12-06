import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
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
              width: MediaQuery.of(context).size.width * .8,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color.fromARGB(255, 3, 16, 34),
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
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(right: 10),
                      padding: EdgeInsets.all(10),
                      width: 130,
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(255, 3, 16, 34),
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
                        children: [
                          Container(
                            width: double.infinity,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.grey[900],
                              borderRadius: BorderRadius.circular(8),
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
          ],
        ),
      ),
    );
  }
}
