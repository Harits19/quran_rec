import 'package:flutter/material.dart';
import 'package:quran_rec/components/page_viewer.dart';
import 'package:quran_rec/models/quran_metadata_model.dart';
import 'package:quran_rec/models/quran_model.dart';
import 'package:quran_rec/services/debug_service.dart';
import 'package:quran_rec/services/xml_service.dart';
import 'package:xml/xml.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final xmlService = XmlService();

  QuranModel? quranModel;
  QuranMetadataModel? quranMetadataModel;

  List<SuraModel> get suras {
    return quranModel?.suras ?? [];
  }

  void loadQuranMetadata() async {
    final document = await xmlService.readXMLFile(XMLFile.quranData);
    final result = QuranMetadataModel.fromXML(document);
    myLog("example page ${result.pages.last.sura}");
    quranMetadataModel = result;
    setState(() {});
  }

  void loadQuranUthmani() async {
    final document = await xmlService.readXMLFile(XMLFile.quranUthmani);

    final result = QuranModel.fromXML(document);

    final suras = result.suras;
    myLog("suras length ${suras.length}");

    final exampleAya = result.suras.last.ayas.first.bismillah;

    myLog("exampleAya $exampleAya");
    quranModel = result;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadQuranUthmani();
    loadQuranMetadata();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: ThemeData(),
      darkTheme: ThemeData.dark(),
      home: Scaffold(
        body: SafeArea(
          child: PageView.builder(
            scrollBehavior: ScrollBehavior(),
            reverse: true,
            itemCount: suras.length,
            itemBuilder:
                (context, index) =>
                    PageViewer(key: Key(index.toString()), sura: suras[index]),
          ),
        ),
      ),
    );
  }
}
