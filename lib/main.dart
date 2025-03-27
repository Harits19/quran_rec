import 'package:flutter/material.dart';
import 'package:quran_rec/components/page_viewer.dart';
import 'package:quran_rec/models/quran_uthmani_model.dart';
import 'package:quran_rec/services/debug_service.dart';
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

  QuranUthmaniModel? quranUthmaniModel;

  void loadQuranUthmani() async {
    final document = await xmlService.readXMLFile(XMLFile.quranUthmani);

    final result = QuranUthmaniModel.fromJson(document);

    quranUthmaniModel = result;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadQuranUthmani();
  }

  @override
  Widget build(BuildContext context) {
    // myLog("totalPage ${quranUthmaniModel?.totalPage}");
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: ThemeData(),
      darkTheme: ThemeData.dark(),
      home: Scaffold(
        body: SafeArea(
          child:
              quranUthmaniModel == null
                  ? Center(child: CircularProgressIndicator())
                  : PageView.builder(
                    scrollBehavior: ScrollBehavior(),
                    reverse: true,
                    itemCount: quranUthmaniModel?.totalPage,
                    itemBuilder: (context, index) {
                      return PageViewer(
                        key: Key(index.toString()),
                        index: index,
                        quranModel: quranUthmaniModel!,
                      );
                    },
                  ),
        ),
      ),
    );
  }
}
