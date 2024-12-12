import 'dart:io';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:permission_handler/permission_handler.dart';

class Providerstate extends ChangeNotifier {
  final audioPlayer = AudioPlayer();
  List<FileSystemEntity> musicFiles = [];
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  int currentIndex = 0;
  bool showMiniPlayer = false;
  bool isRestart = false;
  bool isIcon = false;
  bool isDisc = false;
  bool isfav = false;
  bool isRepeat = false;
  bool isShuffle = false;

  // Future<void> requstPermission() async {
  //   var status = await Permission.storage.request();
  //   if (status.isGranted ||
  //       await Permission.manageExternalStorage.request().isGranted) {
  //     print("Permission granted");
  //   } else {
  //     print("Permission Denied");
  //   }
  // }

  // Future<List<FileSystemEntity>> getMusicFiles() async {
  //   final directory = Directory('/storage/emulated/0/Music');
  //   if (await directory.exists()) {
  //     return directory.listSync();
  //   } else {
  //     return [];
  //   }
  // }
  void duPos() {
    audioPlayer.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        isIcon = true;
        // _controller1.reverse();
        isRestart = true;
        notifyListeners();
      }
    });
    audioPlayer.durationStream.listen((pduration) {
      if (pduration != null) {
        duration = pduration;
        notifyListeners();
      }
    });

    audioPlayer.positionStream.listen((cposition) {
      try {
        position = cposition;
        notifyListeners();
      } catch (e) {
        print(
            "======================================================================");
        print(e);
        print(
            "======================================================================");
      }
    });
  }

  void restartSong() {
    audioPlayer.seek(Duration.zero);
    audioPlayer.play();
    isRestart = false;
    isIcon = false;
    notifyListeners();
  }

  void seek(double value) {
    final pos = Duration(seconds: value.toInt());
    audioPlayer.seek(pos);
    notifyListeners();
  }

  Future<void> playAudio(String filePath) async {
    try {
      await audioPlayer.setFilePath(filePath);
      await audioPlayer.play();
    } catch (e) {
      print("Error occured :$e");
    }
    notifyListeners();
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes);
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    // notifyListeners();
    return "$minutes:$seconds";
  }

  // Future<void> fetchMusic() async {
  //   await requstPermission();
  //   final files = await getMusicFiles();
  //   _musicFiles = files;
  // }
  @override
  void dispose() {
    // _controller.dispose();
    // _controller1.dispose();
    audioPlayer.dispose();
    super.dispose();
  }
}
