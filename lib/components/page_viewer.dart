import 'package:flutter/material.dart';
import 'package:quran_rec/components/my_rich_text.dart';
import 'package:quran_rec/components/my_text_span.dart';
import 'package:quran_rec/components/my_text_style.dart';
import 'package:quran_rec/models/quran_uthmani_model.dart';

class PageViewer extends StatelessWidget {
  const PageViewer({super.key, required this.quranModel, required this.index});

  final QuranUthmaniModel quranModel;
  final int index;

  @override
  Widget build(BuildContext context) {
    final currentPage = index + 1;
    final ayah = quranModel.allAyah.where((e) => e.page == currentPage);
    final currentJuz = ayah.last.juz ?? 0;

    return DefaultTextStyle(
      style: MyTextStyle(
        context: context,
        fontFamily: FontFamily.amiri,
        fontSize: 16,
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text("Page $currentPage"), Text("Juz $currentJuz")],
            ),
            Spacer(),
            MyRichText(
              text:
                  (context) => MyTextSpan(
                    context: context,
                    style: MyTextStyle(context: context, fontSize: 16),
                    children:
                        ayah.map((e) {
                          return TextSpan(
                            text: "${e.text} (${e.numberInSurah}) ",
                          );
                        }).toList(),
                  ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
