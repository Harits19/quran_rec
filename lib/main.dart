import 'package:flutter/material.dart';
import 'package:quran_rec/context/extension.dart';
import 'package:quran_rec/quran/provider.dart';
import 'package:quran_rec/quran/view.dart';
import 'package:quran_rec/quran/model.dart';
import 'package:quran_rec/record/provider.dart';
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
  bool showRecordView = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: ThemeData(fontFamily: FontFamily.amiri),
      darkTheme: ThemeData.dark(),
      home: Scaffold(
        body: RecordProvider(
          builder: (record, recordAction) {
            return QuranProvider(
              builder: (quran, recordAction) {
                if (quran == null) {
                  return Center(child: CircularProgressIndicator());
                }
                return Stack(
                  children: [
                    Positioned.fill(
                      child: GestureDetector(
                        onTap: () {
                          showRecordView = !showRecordView;
                          setState(() {});
                        },
                        child: PageView.builder(
                          scrollBehavior: ScrollBehavior(),
                          reverse: true,
                          itemCount: quran.totalPage,
                          itemBuilder: (context, index) {
                            return PageViewer(
                              key: Key(index.toString()),
                              index: index,
                              quranModel: quran,
                            );
                          },
                        ),
                      ),
                    ),
            
                    if (showRecordView) RecordView(),
                  ],
                );
              },
            );
          }
        ),
      ),
    );
  }
}
