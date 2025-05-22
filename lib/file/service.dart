import 'dart:io';

import 'package:quran_rec/quran/model.dart';

class FileService {
  final Ayahs ayah;

  FileService(this.ayah);

  static FileService tryCreate(Ayahs? ayah) {
    if (ayah == null) {
      throw Exception("Empty ayah");
    }
    return FileService(ayah);
  }

  String get path {
    return '$audioPath/$filename.m4a';
  }

  static const audioPath = '/storage/emulated/0/Audio';

  static initFolder() async {
    final audioDir = Directory(audioPath);
    if (!await audioDir.exists()) {
      await audioDir.create(recursive: true);
    }
  }

  String get filename {
    return ayah.number.toString();
  }

  Future<bool> exist() async {
    final file = File(path);
    return await file.exists();
  }
}
