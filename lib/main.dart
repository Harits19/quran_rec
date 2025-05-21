import 'package:flutter/material.dart';
import 'package:quran_rec/quran/provider.dart';
import 'package:quran_rec/quran/view.dart';
import 'package:quran_rec/record/provider.dart';
import 'package:quran_rec/record/view.dart';
import 'package:quran_rec/text_style/constant.dart';

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
        body: QuranProvider(
          builder: (quran, recordAction) {
            if (quran == null) {
              return Center(child: CircularProgressIndicator());
            }
            return RecordProvider(
              quran: quran,
              builder: (record, recordAction) {
                return Column(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          showRecordView = !showRecordView;
                          setState(() {});
                        },
                        child: PageView.builder(
                          controller: record.controller,
                          scrollBehavior: ScrollBehavior(),
                          reverse: true,
                          itemCount: quran.pages.length,
                          itemBuilder: (context, index) {
                            return PageViewer(
                              key: Key(index.toString()),
                              index: index,
                              ayahs: quran.pages[index],
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
          },
        ),
      ),
    );
  }
}
