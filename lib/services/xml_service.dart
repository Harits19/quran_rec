import 'dart:io';
import 'package:quran_rec/services/debug_service.dart';
import 'package:xml/xml.dart';
import 'package:flutter/services.dart';

class XmlService {
  void readXMLFile(String path) async {
    final fileContent = await rootBundle.loadString(path);
    final document = XmlDocument.parse(fileContent);
    final suras = document.findAllElements("suras").first.descendantElements;
    final exampleSura = suras.first;

    myLog("example document result $exampleSura");
    myLog("length ${suras.length}");

    myLog("example name : ${exampleSura.getAttribute("name")}");
    myLog("example ayas : ${exampleSura.getAttribute("ayas")}");

    // for (final sura in suras) {
    //   myLog("sura $sura");
    // }
  }
}
