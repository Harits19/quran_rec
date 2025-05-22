import 'package:flutter/material.dart';
import 'package:quran_rec/ayah/view.dart';
import 'package:quran_rec/context/extension.dart';
import 'package:quran_rec/quran/model.dart';
import 'package:quran_rec/quran/provider.dart';
import 'package:quran_rec/record/provider.dart';
import 'package:quran_rec/text_style/constant.dart';
import 'package:quran_rec/number/extension.dart';

class PageViewer extends StatelessWidget {
  const PageViewer({super.key, required this.ayahs, required this.index});

  final List<Ayahs> ayahs;
  final int index;

  @override
  Widget build(BuildContext context) {
    final currentPage = index + 1;
    final currentJuz = ayahs.last.juz ?? 0;
    final currentSurah = ayahs.last.surah?.name;

    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
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

            AyahView( ayahs: ayahs)
          ],
        ),
      ),
    );
  }
}
