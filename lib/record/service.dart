import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quran_rec/debug/service.dart';
import 'package:quran_rec/file/service.dart';
import 'package:quran_rec/quran/model.dart';
import 'package:record/record.dart';
import 'package:permission_handler/permission_handler.dart';

class RecordService {
  RecordService._({required this.record});

  final AudioRecorder record;

  static RecordService create() {
    final record = AudioRecorder();

    return RecordService._(record: record);
  }

  Future<void> start({required Ayahs? ayah}) async {
    final file = FileService.tryCreate(ayah);
    final hasPermission = await record.hasPermission();
    final isGranted =
        (await Permission.manageExternalStorage.request()) ==
        PermissionStatus.granted;
    if (!hasPermission || !isGranted) {
      return;
    }

    await FileService.initFolder();

    final path = file.path;

    myLog("start record audio with on $path");
    await record.start(const RecordConfig(), path: path);
  }

  Future<void> stop() async {
    final path = await record.stop();
    await record.dispose();

    myLog("stop record audio with on $path");
  }

}
