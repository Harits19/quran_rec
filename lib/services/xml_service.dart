import 'dart:convert';

import 'package:flutter/services.dart';

enum XMLFile {
  quranUthmani(path: 'quran-uthmani');

  const XMLFile({required this.path});
  final String path;

  String get assetsPath {
    return "assets/$path.json";
  }
}

class XmlService {
  Future<dynamic> readXMLFile(XMLFile path) async {
    final fileContent = await rootBundle.loadString(path.assetsPath);

    return jsonDecode(fileContent);
  }
}
