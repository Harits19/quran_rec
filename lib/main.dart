import 'package:flutter/material.dart';
import 'package:quran_rec/constants/assets.dart';
import 'package:quran_rec/services/xml_service.dart';

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: FilledButton(
            onPressed: () {
              xmlService.readXMLFile(KAssets.quranData);
            },
            child: Text("Read XML File"),
          ),
        ),
      ),
    );
  }
}
