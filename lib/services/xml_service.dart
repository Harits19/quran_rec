import 'package:xml/xml.dart';
import 'package:flutter/services.dart';

enum XMLFile {
  quranData(path: 'quran-data'),
  quranUthmani(path: 'quran-uthmani');

  const XMLFile({required this.path});
  final String path;

  String get assetsPath {
    return "assets/$path.xml";
  }
}

class XmlService {
  Future<XmlDocument> readXMLFile(XMLFile path) async {
    final fileContent = await rootBundle.loadString(path.assetsPath);
    final document = XmlDocument.parse(fileContent);
    return document;
  }
}
