import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:quran_rec/debug/service.dart';
import 'package:quran_rec/file/service.dart';
import 'package:quran_rec/quran/model.dart';

class AudioPlayerService {
  final player = AudioPlayer();
  Completer<void>? completer;

  Future<void> play({required Ayahs? ayah}) async {
    final file = FileService.tryCreate(ayah);
    final filePath = file.path;
    completer = Completer();

    player.onPlayerComplete.listen((event) {
      myLog('Audio playback finished!');
      if (!completer!.isCompleted) completer?.complete(); // Resolves the future
    });

    player.onPlayerStateChanged.listen((event) {
      if (event == PlayerState.stopped && !completer!.isCompleted) {
        completer?.complete(); // Resolves the future
      }
    });

    await player.play(DeviceFileSource(filePath));

    myLog('Playing audio... $filePath');
    await completer?.future;
    await player.release();
    completer = null;
  }

  Future<void> stop() async {
    await player.stop();
    completer?.complete();
  }
}
