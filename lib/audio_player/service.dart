import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:quran_rec/debug/service.dart';
import 'package:quran_rec/file/service.dart';
import 'package:quran_rec/quran/model.dart';

class AudioPlayerService {
  AudioPlayer? player;
  Completer<void> completer = Completer();

  Future<void> play({required Ayahs? ayah}) async {
    final file = FileService.tryCreate(ayah);
    final filePath = file.path;
    completer = Completer();
    player = AudioPlayer(playerId: filePath);

    player?.onPlayerComplete.listen((event) {
      myLog('Audio playback finished!');
      if (!completer.isCompleted) {
        completer.complete(); // Resolves the future
      }
    });

    await player?.play(DeviceFileSource(filePath));

    myLog('Playing audio... $filePath');
    await completer.future;
    myLog('Complete audio... $filePath');

    await player?.release();
  }

  Future<void> stop() async {
    await player?.stop();
    await player?.release();
    await player?.dispose();
    if (!completer.isCompleted) {
      completer.complete();
    }
  }
}
