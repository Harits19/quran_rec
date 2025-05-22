import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:quran_rec/context/extension.dart';
import 'package:quran_rec/number/extension.dart';
import 'package:quran_rec/quran/model.dart';
import 'package:quran_rec/quran/provider.dart';
import 'package:quran_rec/record/provider.dart';
import 'package:quran_rec/text_style/constant.dart';

class AyahView extends StatelessWidget {
  const AyahView({super.key, required this.ayahs});

  final List<Ayahs> ayahs;

  @override
  Widget build(BuildContext context) {
    final view = context.of<QuranViewModel>().state.view;
    final action = context.of<RecordViewModel>().action;

    TextStyle ayahStyle(Ayahs e) {
      final isSelected =
          context.of<RecordViewModel>().state.selectedAyah?.number == e.number;
      return TextStyle(
        color: isSelected ? Colors.blue : null,
        fontSize: 16,
        height: 2.5,
        wordSpacing: 1.5,
        fontFamily: FontFamily.amiri,
      );
    }

    String ayahText(Ayahs e) {
      return "${e.text} (${e.numberInSurah?.toArabicNumber()}) ";
    }

    void handleClick(Ayahs ayah) {
      final isSelected =
          context.of<RecordViewModel>().state.selectedAyah?.number ==
          ayah.number;
      if (isSelected) {
        action.onSelectAyah(null);
      } else {
        action.onSelectAyah(ayah);
      }
    }

    if (view == QuranView.wrap) {
      return RichText(
        text: TextSpan(
          children:
              ayahs.map((e) {
                return TextSpan(
                  style: ayahStyle(e),
                  text: ayahText(e),
                  recognizer:
                      TapGestureRecognizer()
                        ..onTap = () {
                          handleClick(e);
                        },
                );
              }).toList(),
        ),
      );
    }

    if (view == QuranView.list) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...ayahs.map((e) {
            return Card(
              clipBehavior: Clip.hardEdge,
              child: ListTile(
                title: Text(ayahText(e), style: ayahStyle(e)),
                onTap: () {
                  handleClick(e);
                },
              ),
            );
          }),
        ],
      );
    }

    throw UnimplementedError();
  }
}
