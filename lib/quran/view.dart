import 'package:flutter/material.dart';
import 'package:quran_rec/quran/model.dart';
import 'package:quran_rec/text_style/constant.dart';
import 'package:quran_rec/number/extension.dart';

class PageViewer extends StatelessWidget {
  const PageViewer({super.key, required this.quranModel, required this.index});

  final QuranModel quranModel;
  final int index;

  @override
  Widget build(BuildContext context) {
    final currentPage = index + 1;
    final ayah = quranModel.allAyah.where((e) => e.page == currentPage);
    final currentJuz = ayah.last.juz ?? 0;
    final currentSurah = ayah.last.surah?.name;

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Page $currentPage"),
              Text("$currentSurah"),
              Text("Juz $currentJuz"),
            ],
          ),
    
          SizedBox(height: 32),
    
          RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 16,
                height: 2.5,
                wordSpacing: 1.5,
                fontFamily: FontFamily.amiri,
              ),
              children:
                  ayah.map((e) {
                    return TextSpan(
                      text:
                          "${e.text} (${e.numberInSurah?.toArabicNumber()}) ",
                    );
                  }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
