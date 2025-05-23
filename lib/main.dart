import 'package:flutter/material.dart';
import 'package:quran_rec/local/provider.dart';
import 'package:quran_rec/quran/provider.dart';
import 'package:quran_rec/quran/view.dart';
import 'package:quran_rec/record/provider.dart';
import 'package:quran_rec/footer/view.dart';
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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: ThemeData(fontFamily: FontFamily.amiri),
      darkTheme: ThemeData.dark(),
      home: Scaffold(
        body: LocalProvider(
          builder: (state, action) {
            return QuranProvider(
              builder: (quranState, recordAction) {
                final quran = quranState.quran;
                if (quran == null) {
                  return Center(child: CircularProgressIndicator());
                }
                return RecordProvider(
                  quran: quran,
                  builder: (recordState, recordAction) {
                    final showButton = recordState.selectedAyah != null;
                    final isPlaying = recordState.isPlaying;
                    final isRecording = recordState.isRecording;
                    return Column(
                      children: [
                        Expanded(
                          child: IgnorePointer(
                            ignoring: isRecording || isPlaying,
                            child: PageView.builder(
                              controller: recordState.controller,
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
            
                        if (showButton) FooterView(),
                      ],
                    );
                  },
                );
              },
            );
          }
        ),
      ),
    );
  }
}
