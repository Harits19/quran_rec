import 'package:flutter/material.dart';
import 'package:quran_rec/quran/view.dart';
import 'package:quran_rec/quran/model.dart';
import 'package:quran_rec/record/view.dart';
import 'package:quran_rec/debug/service.dart';
import 'package:quran_rec/text_style/constant.dart';
import 'package:quran_rec/xml/service.dart';

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

  QuranModel? quranUthmaniModel;

  void loadQuranUthmani() async {
    final document = await xmlService.readXMLFile(XMLFile.quranUthmani);

    final result = QuranModel.fromJson(document);

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
      theme: ThemeData(fontFamily: FontFamily.amiri),
      darkTheme: ThemeData.dark(),
      home: Scaffold(
        body:
            quranUthmaniModel == null
                ? Center(child: CircularProgressIndicator())
                : Stack(
                  children: [
                    Positioned.fill(
                      child: GestureDetector(
                        onTap: () {},
                        child: PageView.builder(
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

                    RecordView(),
                  ],
                ),
      ),
    );
  }
}
